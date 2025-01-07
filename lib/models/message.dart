import 'package:get/get.dart';

class Message {
  final String sentBy;
  final RxnString message;
  final DateTime dateTime;

  Message({
    required this.sentBy,
    String? message,
    required this.dateTime,
  }) : message = RxnString(message);
}
