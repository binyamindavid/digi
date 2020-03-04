// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snatchbot_message_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatReponseModel _$ChatReponseModelFromJson(Map<String, dynamic> json) {
  return ChatReponseModel(
    cards: json['cards'] as List ?? [],
    messages: (json['messages'] as List)
            ?.map((e) => e == null
                ? null
                : SnatchbotMessage.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    status: json['status'] ?? false,
    suggested: (json['suggested'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ChatReponseModelToJson(ChatReponseModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cards', instance.cards);
  writeNotNull('messages', instance.messages);
  writeNotNull('status', instance.status);
  writeNotNull('suggested', instance.suggested);
  return val;
}
