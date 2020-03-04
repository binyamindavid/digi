class AddMessageAction {
  final payload;
  final notificationSink;

  AddMessageAction(this.payload, this.notificationSink);
}

class AddAllMessagesAction {
  final payload;
  final notificationSink;

  AddAllMessagesAction(this.payload, {this.notificationSink});
}

class DeleteAllMessagesAction {}
