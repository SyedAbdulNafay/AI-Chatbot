import 'package:get/get.dart';

class Message {
  final String sentBy;
  final RxnString message;
  final DateTime dateTime;
  bool showAnimation;

  Message({
    required this.sentBy,
    String? message,
    required this.dateTime,
    this.showAnimation = true,
  }) : message = RxnString(message);

  Map<String, dynamic> toJson() {
    return {
      'sentBy': sentBy,
      'message': message.value,
      'dateTime': dateTime.toIso8601String(),
      'showAnimation': showAnimation,
    };
  }

  static Message fromJson(Map<String, dynamic> json) {
    return Message(
      sentBy: json['sentBy'],
      message: json['message'],
      dateTime: DateTime.parse(json['dateTime']),
      showAnimation: json['showAnimation'],
    );
  }
}

class Chat {
  final String chatId;
  final String title;
  DateTime lastUpdated;
  List<Message> messages;

  Chat({
    required this.chatId,
    required this.title,
    required this.lastUpdated,
    required this.messages,
  });

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'title': title,
      'lastUpdated': lastUpdated.toIso8601String(),
      'messages': messages.map((m) => m.toJson()).toList(),
    };
  }

  static Chat fromJson(Map<String, dynamic> json) {
    return Chat(
      chatId: json['chatId'],
      title: json['title'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      messages:
          (json['messages'] as List).map((m) => Message.fromJson(m)).toList(),
    );
  }
}
