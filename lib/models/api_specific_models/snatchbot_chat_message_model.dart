import 'package:json_annotation/json_annotation.dart';
part 'snatchbot_chat_message_model.g.dart';

@JsonSerializable()
class SnatchbotMessage {
  @JsonKey(defaultValue: "", nullable: true, includeIfNull: false)
  final String message;
  @JsonKey(defaultValue: "", nullable: true, includeIfNull: false)
  final String speech;

  SnatchbotMessage({this.message, this.speech});

  factory SnatchbotMessage.fromJson(Map<String, dynamic> json) =>
      _$SnatchbotMessageFromJson(json);

  ///Transforms a json encoded string to a dart object of the appropriate type
  Map<String, dynamic> toJson() => _$SnatchbotMessageToJson(this);
}
