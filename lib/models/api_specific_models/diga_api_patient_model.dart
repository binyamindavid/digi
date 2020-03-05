import 'package:json_annotation/json_annotation.dart';
import 'package:digamobile/models/api_specific_models/diga_appointment_model.dart';

part 'diga_api_patient_model.g.dart';

@JsonSerializable()
class DiagPatientModel {
  @JsonKey(name: "id", nullable: true, includeIfNull: false)
  final int id;
  @JsonKey(
      name: "first_name",
      defaultValue: "",
      nullable: true,
      includeIfNull: false)
  final String firstName;
  @JsonKey(
      name: "last_name", defaultValue: "", nullable: true, includeIfNull: false)
  final String lastName;
  @JsonKey(
      name: "mobile", defaultValue: "", nullable: true, includeIfNull: false)
  final String mobile;
  @JsonKey(
      name: "email", defaultValue: "", nullable: true, includeIfNull: false)
  final String email;
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
  @JsonKey(
      name: "appointments",
      defaultValue: [],
      nullable: true,
      includeIfNull: false)
  final List<DigaAppointmentModel> appointments;

  DiagPatientModel(
      {this.id,
      this.lastName,
      this.mobile,
      this.email,
      this.createdDate,
      this.updateDate,
      this.appointments,
      this.firstName});

  factory DiagPatientModel.fromJson(Map<String, dynamic> json) =>
      _$DiagPatientModelFromJson(json);

  ///Transforms a json encoded string to a dart object of the appropriate type
  Map<String, dynamic> toJson() => _$DiagPatientModelToJson(this);
}
