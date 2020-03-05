// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diga_api_patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiagPatientModel _$DiagPatientModelFromJson(Map<String, dynamic> json) {
  return DiagPatientModel(
    id: json['id'] as int,
    lastName: json['last_name'] as String ?? '',
    mobile: json['mobile'] as String ?? '',
    email: json['email'] as String ?? '',
    createdDate: json['created_at'] as String ?? '',
    updateDate: json['updated_at'] as String ?? '',
    appointments: (json['appointments'] as List)
            ?.map((e) => e == null
                ? null
                : DigaAppointmentModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    firstName: json['first_name'] as String ?? '',
  );
}

Map<String, dynamic> _$DiagPatientModelToJson(DiagPatientModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('mobile', instance.mobile);
  writeNotNull('email', instance.email);
  writeNotNull('created_at', instance.createdDate);
  writeNotNull('updated_at', instance.updateDate);
  writeNotNull('appointments', instance.appointments);
  return val;
}
