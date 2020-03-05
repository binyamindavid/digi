import 'package:json_annotation/json_annotation.dart';

part 'diga_appointment_model.g.dart';

@JsonSerializable()
class DigaAppointmentModel {
  DigaAppointmentModel(
      {this.appointmentID,
      this.appointmentDate,
      this.appointmentTime,
      this.patientID,
      this.clinicID,
      this.createdDate,
      this.updateDate});
  @JsonKey(name: "id", nullable: true, includeIfNull: false)
  final int appointmentID;
  @JsonKey(
      name: "appointment_date",
      defaultValue: "",
      nullable: true,
      includeIfNull: false)
  final String appointmentDate;
  @JsonKey(
      name: "appointment_time",
      defaultValue: "",
      nullable: true,
      includeIfNull: false)
  final String appointmentTime;
  @JsonKey(name: "patient_id", nullable: true, includeIfNull: false)
  final String patientID;
  @JsonKey(name: "clinic_id", nullable: true, includeIfNull: false)
  final String clinicID;
  @JsonKey(
      name: "created_at",
      defaultValue: "",
      nullable: true,
      includeIfNull: false)
  final String createdDate;
  @JsonKey(
      name: "updated_at",
      defaultValue: "",
      nullable: true,
      includeIfNull: false)
  final String updateDate;

  factory DigaAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$DigaAppointmentModelFromJson(json);

  ///Transforms a json encoded string to a dart object of the appropriate type
  Map<String, dynamic> toJson() => _$DigaAppointmentModelToJson(this);
}
