class AddClinicAction {
  final payload;

  AddClinicAction({this.payload});
}

class ListClinicsAction {}

class UpdateClinicAction {
  final payload;

  UpdateClinicAction(this.payload);
}

class DestroyClinicAction {
  final clinicId;

  DestroyClinicAction(this.clinicId);
}
