import 'package:digamobile/models/api_specific_models/snatchbot_chat_message_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'snatchbot_message_response_model.g.dart';

@JsonSerializable()
class ChatReponseModel {
  @JsonKey(defaultValue: [], nullable: true, includeIfNull: false)
  final List cards;
  @JsonKey(defaultValue: [], nullable: true, includeIfNull: false)
  final List<SnatchbotMessage> messages;
  @JsonKey(defaultValue: false, nullable: true, includeIfNull: false)
  final status;
  @JsonKey(defaultValue: null, nullable: true, includeIfNull: false)
  final List<String> suggested;

  ChatReponseModel({this.cards, this.messages, this.status, this.suggested});

  factory ChatReponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChatReponseModelFromJson(json);

  ///Transforms a json encoded string to a dart object of the appropriate type
  Map<String, dynamic> toJson() => _$ChatReponseModelToJson(this);
}
