import 'dart:async';

import 'package:ai_chatbot/models/message.dart';
import 'package:ai_chatbot/models/open_ai_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final OpenAIModel _aiService = OpenAIModel();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  late Timer timer;
  var currentFrame = 01.obs;
  var currentChatId = '';
  var userPrompt = "".obs;
  var messages = <Message>[].obs;
  var chats = <Chat>[].obs;
  var isLoadingChats = false.obs;
  final bulletRegex = RegExp(r'^\* (.*)');
  final boldItalicRegex =
      RegExp(r'\*\*\*(.*?)\*\*\*|\*\*(.*?)\*\*|\*(.*?)\*|~~(.*?)~~');

  @override
  void onInit() {
    super.onInit();
    loadChatsFromFirebase();
  }

  void startAnimation() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      currentFrame.value == 07 ? currentFrame.value = 01 : currentFrame.value++;
    });
  }

  List<TextSpan> parseResponse(String response) {
    final List<TextSpan> spans = [];

    //Split lines to process each line individually
    final lines = response.split('\n');

    for (final line in lines) {
      if (bulletRegex.hasMatch(line)) {
        // Extract the content after the bullet point
        final match = bulletRegex.firstMatch(line);
        if (match != null) {
          final content = match.group(1)!;

          // Parse inline formatting for the bullet content
          spans.add(const TextSpan(
            text: '• ', // Unicode bullet point
            style: TextStyle(fontWeight: FontWeight.bold),
          ));
          spans.addAll(_parseInlineFormatting(content, boldItalicRegex));
          spans.add(
              const TextSpan(text: '\n')); // Newline after each bullet point
        }
      } else {
        // Parse inline formatting for normal lines
        spans.addAll(_parseInlineFormatting(line, boldItalicRegex));
        spans.add(const TextSpan(text: '\n'));
      }
    }

    return spans;
  }

  List<TextSpan> _parseInlineFormatting(String text, RegExp regex) {
    final spans = <TextSpan>[];

    int lastMatchEnd = 0;

    for (final match in regex.allMatches(text)) {
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

  Future<void> loadChatsFromFirebase() async {
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
      textController.clear();

      messages.add(Message(
        sentBy: 'user',
        message: userPrompt.value,
        dateTime: DateTime.now(),
      ));

      final aiMessage = Message(
        sentBy: "ai",
        dateTime: DateTime.now(),
        showAnimation: true,
      );

      messages.add(aiMessage);

      String? response = await _aiService.generateResponse(userPrompt.value);
      userPrompt.value = "";
      aiMessage.message.value = response;
    } else {
      debugPrint(messages[messages.length - 1].message.value);
    }
  }
}
