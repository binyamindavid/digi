// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diga_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DigaAppointmentModel _$DigaAppointmentModelFromJson(Map<String, dynamic> json) {
  return DigaAppointmentModel(
    appointmentID: json['id'] as int,
    appointmentDate: json['appointment_date'] as String ?? '',
    appointmentTime: json['appointment_time'] as String ?? '',
    patientID: json['patient_id'] as int,
    clinicID: json['clinic_id'] as int,
    createdDate: json['created_at'] as String ?? '',
    updateDate: json['updated_at'] as String ?? '',
  );
}

Map<String, dynamic> _$DigaAppointmentModelToJson(
    DigaAppointmentModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.appointmentID);
  writeNotNull('appointment_date', instance.appointmentDate);
  writeNotNull('appointment_time', instance.appointmentTime);
  writeNotNull('patient_id', instance.patientID);
  writeNotNull('clinic_id', instance.clinicID);
  writeNotNull('created_at', instance.createdDate);
  writeNotNull('updated_at', instance.updateDate);
  return val;
}
