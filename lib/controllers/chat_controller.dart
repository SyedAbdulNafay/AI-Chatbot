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
  var currentChatId = '';
  var userPrompt = "".obs;
  var messages = <Message>[].obs;
  var chats = <Chat>[].obs;
  var isLoadingChats = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadChatsFromFirebase();
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

      // if (messages.isNotEmpty) {
      //   if (chats.isNotEmpty &&
      //       chats.any((chat) => chat.chatId == currentChatId)) {
      //     var chat = chats.firstWhere((chat) => chat.chatId == currentChatId);
      //     chat.messages = List.from(messages);
      //     chat.lastUpdated = DateTime.now();
      //     debugPrint("Started saving");
      //     await saveChatToFirebase(chat);
      //   } else {
      //     final chatId = DateTime.now().toIso8601String();
      //     currentChatId = chatId;
      //     final newChat = Chat(
      //       chatId: chatId,
      //       title: messages.first.message.value ?? "New Chat",
      //       lastUpdated: DateTime.now(),
      //       messages: List.from(messages),
      //     );
      //     chats.add(newChat);
      //     await saveChatToFirebase(newChat);
      //   }
      // }
    } else {
      for (var i = 0; i < messages.length; i++) {
        debugPrint(i.toString());
      }
    }
  }
}
