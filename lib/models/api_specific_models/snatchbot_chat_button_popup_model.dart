class SnatchbotChatCardModel {
  final String type;
  final value;
  final List buttons;
  final List galery;

  SnatchbotChatCardModel({this.galery, this.type, this.value, this.buttons});
}

class SnatchbotButtonPopUp {}

class SnatchbotButton {
  final String title;
  final type;
  final url;

  SnatchbotButton({this.title, this.type, this.url});
}
