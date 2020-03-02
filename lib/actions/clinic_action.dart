class AddClinic {
  final payload;

  AddClinic({this.payload});
}

class ListClinics {}

class UpdateClinic {
  final payload;

  UpdateClinic(this.payload);
}

class DestroyClinic {
  final clinicId;

  DestroyClinic(this.clinicId);
}