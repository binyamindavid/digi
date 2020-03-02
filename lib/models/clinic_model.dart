class ClinicModel {
  final id;
  final name;
  final registrationNumber;
  final email;
  final fax;
  final bool status;

  ClinicModel(this.id,
      {this.name, this.registrationNumber, this.email, this.fax, this.status});
}