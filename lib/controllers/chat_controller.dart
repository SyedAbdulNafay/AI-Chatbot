import 'dart:async';

import 'package:ai_chatbot/models/message.dart';
import 'package:ai_chatbot/models/open_ai_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  // Services
  final OpenAIModel _aiService = OpenAIModel();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controllers
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  // Animation Timer
  late Timer _timer;

  // variables
  var currentFrame = 01.obs;
  var currentChatId = '';
  var userPrompt = "".obs;
  var messages = <Message>[].obs;
  var chats = <Chat>[].obs;
  var isLoadingChats = false.obs;
  bool reOpenedChat = false;

  // RegEx patterns for parsing markdown
  final _bulletRegex = RegExp(r'^\* (.*)');
  final _inlineRegex =
      RegExp(r'\*\*\*(.*?)\*\*\*|\*\*(.*?)\*\*|\*(.*?)\*|~~(.*?)~~|`(.*?)`');
  final _codeBlockRegex = RegExp(r'```([\s\S]*?)```');
  final _singleLineCommentRegex = RegExp(r'#.*|//.*');
  final _multiLineCommentRegex = RegExp(
      "(\\'\\'\\'[\\s\\S]*?\\'\\'\\'|\\\"\\\"\\\"[\\s\\S]*?\\\"\\\"\\\")");

  @override
  void onInit() {
    super.onInit();
    _loadChatsFromFirebase();
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      currentFrame.value == 07 ? currentFrame.value = 01 : currentFrame.value++;
    });
  }

  void _stopAnimation() {
    _timer.cancel();
  }

  List<InlineSpan> parseResponse(String response) {
    final List<InlineSpan> spans = [];
    int lastMatchEnd = 0;

    for (final match in _codeBlockRegex.allMatches(response)) {
      // Add plain text before the code block
      if (match.start > lastMatchEnd) {
        spans.addAll(_processNonCodeLines(
            response.substring(lastMatchEnd, match.start)));
      }

      final codeContent = match.group(1)!.trim();
      spans.addAll(_parseCodeBlock(codeContent));

      lastMatchEnd = match.end;
    }

    // Add remaining plain text after the last code block
    if (lastMatchEnd < response.length) {
      spans.addAll(_processNonCodeLines(response.substring(lastMatchEnd)));
    }

    return spans;
  }

  List<InlineSpan> _parseCodeBlock(String code) {
    final List<InlineSpan> spans = [];
    int lastMatchEnd = 0;

    final lines = code.split('\n');

    final firstLine = lines.isNotEmpty ? lines.first : 'Output';

    final remainingCode = lines.length > 1 ? lines.sublist(1).join('\n') : '';

    final matches = [
      ..._singleLineCommentRegex.allMatches(remainingCode),
      ..._multiLineCommentRegex.allMatches(remainingCode),
    ]..sort((a, b) => a.start.compareTo(b.start));

    for (final match in matches) {
      // Add plain text before the match
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: remainingCode.substring(lastMatchEnd, match.start),
          style: const TextStyle(
            fontFamily: 'monospace',
            color: Colors.white,
          ),
        ));
      }

      // Add the matched comment with a green style
      spans.add(TextSpan(
        text: remainingCode.substring(match.start, match.end),
        style: TextStyle(
          color: Colors.green[400],
          fontFamily: 'monospace',
        ),
      ));

      lastMatchEnd = match.end;
    }

    // Add remaining plain text after the last match
    if (lastMatchEnd < remainingCode.length) {
      spans.add(TextSpan(
        text: remainingCode.substring(lastMatchEnd),
        style: const TextStyle(
          fontFamily: 'monospace',
          color: Colors.white,
        ),
      ));
    }

    return [
      WidgetSpan(
          child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              color: Colors.grey[700],
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  firstLine,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: remainingCode));
                  },
                  child: const Row(
                    children: [
                      Icon(
                        size: 16,
                        Icons.copy,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Copy',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              color: Colors.grey[800],
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(children: spans),
            ),
          ),
        ],
      ))
    ];
  }

  List<InlineSpan> _processNonCodeLines(String text) {
    final List<InlineSpan> spans = [];

    for (final line in text.split('\n')) {
      if (_bulletRegex.hasMatch(line)) {
        // Process bullet points
        if (_bulletRegex.firstMatch(line) != null) {
          spans.add(const TextSpan(
            text: '• ', // Unicode bullet point
            style: TextStyle(fontWeight: FontWeight.bold),
          ));
          spans.addAll(
              _parseInlineFormatting(_bulletRegex.firstMatch(line)!.group(1)!));
          spans.add(const TextSpan(text: '\n'));
        }
      } else {
        // Process normal lines
        spans.addAll(_parseInlineFormatting(line));
        spans.add(const TextSpan(text: '\n'));
      }
    }

    return spans;
  }

  List<TextSpan> _parseInlineFormatting(String text) {
    final spans = <TextSpan>[];
    int lastMatchEnd = 0;

    for (final match in _inlineRegex.allMatches(text)) {
      // Add plain text before the match
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      // Handle **bold** and *italic*
      if (match.group(1) != null) {
        spans.add(TextSpan(
          text: match.group(1),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ));
      } else if (match.group(2) != null) {
        spans.add(TextSpan(
          text: match.group(2),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
      } else if (match.group(3) != null) {
        spans.add(TextSpan(
          text: match.group(3),
          style: const TextStyle(fontStyle: FontStyle.italic),
        ));
      } else if (match.group(4) != null) {
        spans.add(TextSpan(
          text: match.group(4),
          style: const TextStyle(
            decoration: TextDecoration.lineThrough,
          ),
        ));
      } else if (match.group(5) != null) {
        spans.add(TextSpan(
          text: match.group(5),
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'monospace',
            backgroundColor: Colors.grey[500],
          ),
        ));
      }

      lastMatchEnd = match.end;
    }

    // Add remaining plain text after the last match
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }
    return spans;
  }

  Future<void> saveChatToFirebase() async {
    if (messages.isNotEmpty) {
      if (chats.isNotEmpty &&
          chats.any((chat) => chat.chatId == currentChatId)) {
        var chat = chats.firstWhere((chat) => chat.chatId == currentChatId);
        chat.messages = List.from(messages);
        chat.lastUpdated = DateTime.now();

        final user = auth.currentUser;
        if (user == null) return;

        final userChatsRef = _firestore
            .collection('Users')
            .doc(user.uid)
            .collection('Chats')
            .doc(chat.chatId);

        await userChatsRef.set(chat.toJson());
      } else {
        final chatId = DateTime.now().toIso8601String();
        currentChatId = chatId;
        final newChat = Chat(
          chatId: chatId,
          title: messages.first.message.value ?? "New Chat",
          lastUpdated: DateTime.now(),
          messages: List.from(messages),
        );
        chats.add(newChat);

        final user = auth.currentUser;
        if (user == null) return;

        final userChatsRef = _firestore
            .collection('Users')
            .doc(user.uid)
            .collection('Chats')
            .doc(newChat.chatId);

        await userChatsRef.set(newChat.toJson());
      }
    }
  }

  Future<void> _loadChatsFromFirebase() async {
    isLoadingChats.value = true;
    final user = auth.currentUser;
    if (user == null) return;

    final userChatsRef =
        _firestore.collection('Users').doc(user.uid).collection('Chats');
    final snapshot = await userChatsRef.get();

    chats.value =
        snapshot.docs.map((doc) => Chat.fromJson(doc.data())).toList();
    isLoadingChats.value = false;
  }

  Future<void> onSend() async {
    if (textController.text.isNotEmpty) {
      _startAnimation();
      textController.clear();

      // Add user message to the chat
      messages.add(Message(
        sentBy: 'user',
        message: userPrompt.value,
        dateTime: DateTime.now(),
      ));

      // Add AI response to the chat
      final aiMessage = Message(
        sentBy: "ai",
        dateTime: DateTime.now(),
      );

      messages.add(aiMessage);

      // Prepare context by extracting previous messages
      List<Map<String, String>> contextHistory = [];

      if (reOpenedChat) {
        contextHistory = messages.map((message) {
          return {
            'role': message.sentBy == "user" ? "user" : "model",
            'content': message.message.value ?? '',
          };
        }).toList();
      }

      // Limit context size if needed (e.g. last 10 messages)
      if (contextHistory.length > 10) {
        contextHistory = contextHistory.sublist(contextHistory.length - 10);
      }

      aiMessage.message.value = await _aiService.generateResponseStream(
          userPrompt.value, contextHistory);
      userPrompt.value = "";
      _stopAnimation();
      // _saveChatToFirebase();
    } else {
      debugPrint(messages[messages.length - 1].message.value);
    }
  }
}
