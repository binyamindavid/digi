import 'package:digamobile/models/api_specific_models/diga_api_patient_model.dart';

class SaveInformationOnLogin {
  final payload;

  SaveInformationOnLogin({this.payload});
}

class SavePatientDataAction {
  final DiagPatientModel patientData;

  SavePatientDataAction({this.patientData});
}

class UpdatePatientDataAction {
  final DiagPatientModel patientData;

  UpdatePatientDataAction({this.patientData});
}

class DeletePatientDataAction {
  final patientId;

  DeletePatientDataAction({this.patientId});
}
