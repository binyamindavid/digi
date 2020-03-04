// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snatchbot_chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnatchbotMessage _$SnatchbotMessageFromJson(Map<String, dynamic> json) {
  return SnatchbotMessage(
    message: json['message'] as String ?? '',
    speech: json['speech'] as String ?? '',
  );
}

Map<String, dynamic> _$SnatchbotMessageToJson(SnatchbotMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  writeNotNull('speech', instance.speech);
  return val;
}
