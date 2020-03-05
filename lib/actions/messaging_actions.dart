import 'package:dash_chat/dash_chat.dart';

class AddMessageAction {
  final payload;
  final notificationSink;

  AddMessageAction({this.payload, this.notificationSink});
}

class AddAllMessagesAction {
  final List<ChatMessage> payload;
  final notificationSink;

  AddAllMessagesAction(this.payload, {this.notificationSink});
}

class DeleteAllMessagesAction {}
