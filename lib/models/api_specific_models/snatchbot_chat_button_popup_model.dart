import 'package:json_annotation/json_annotation.dart';

part 'snatchbot_chat_button_popup_model.g.dart';

@JsonSerializable()
class SnatchbotChatCardModel {
  @JsonKey(defaultValue: "", nullable: true, includeIfNull: false)
  final String type;
  @JsonKey(nullable: true, includeIfNull: false)
  final value;
  @JsonKey(defaultValue: [], nullable: true, includeIfNull: false)
  final List buttons;
  @JsonKey(defaultValue: [], nullable: true, includeIfNull: false)
  final List galery;

  SnatchbotChatCardModel({this.galery, this.type, this.value, this.buttons});

  factory SnatchbotChatCardModel.fromJson(Map<String, dynamic> json) =>
      _$SnatchbotChatCardModelFromJson(json);

  ///Transforms a json encoded string to a dart object of the appropriate type
  Map<String, dynamic> toJson() => _$SnatchbotChatCardModelToJson(this);
}

class SnatchbotButtonPopUp {}

@JsonSerializable()
class SnatchbotButton {
  @JsonKey(defaultValue: "", nullable: true, includeIfNull: false)
  final String title;
  @JsonKey(nullable: true, includeIfNull: false)
  final type;
  @JsonKey(defaultValue: "", nullable: true, includeIfNull: false)
  final url;

  SnatchbotButton({this.title, this.type, this.url});

  factory SnatchbotButton.fromJson(Map<String, dynamic> json) =>
      _$SnatchbotButtonFromJson(json);

  ///Transforms a json encoded string to a dart object of the appropriate type
  Map<String, dynamic> toJson() => _$SnatchbotButtonToJson(this);
}
