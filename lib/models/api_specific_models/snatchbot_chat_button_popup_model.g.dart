// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snatchbot_chat_button_popup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnatchbotChatCardModel _$SnatchbotChatCardModelFromJson(
    Map<String, dynamic> json) {
  return SnatchbotChatCardModel(
    galery: json['galery'] as List ?? [],
    type: json['type'] as String ?? '',
    value: json['value'],
    buttons: json['buttons'] as List ?? [],
  );
}

Map<String, dynamic> _$SnatchbotChatCardModelToJson(
    SnatchbotChatCardModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('value', instance.value);
  writeNotNull('buttons', instance.buttons);
  writeNotNull('galery', instance.galery);
  return val;
}

SnatchbotButton _$SnatchbotButtonFromJson(Map<String, dynamic> json) {
  return SnatchbotButton(
    title: json['title'] as String ?? '',
    type: json['type'],
    url: json['url'] ?? '',
  );
}

Map<String, dynamic> _$SnatchbotButtonToJson(SnatchbotButton instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('type', instance.type);
  writeNotNull('url', instance.url);
  return val;
}
