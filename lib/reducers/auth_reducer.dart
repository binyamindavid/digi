import 'package:digamobile/actions/auth_actions.dart';
import 'package:digamobile/models/api_specific_models/diga_api_patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseUser authReducer(FirebaseUser currentUser, action) {
  if (action is SaveInformationOnLogin) {
    //Only saving, do nothing
    return action.payload;
  } else {
    return currentUser;
  }
}

DiagPatientModel patientReducer(DiagPatientModel currentPatient, action) {
  if (action is SavePatientDataAction) {
    return action.patientData;
  }
  if (action is UpdatePatientDataAction) {
    return new DiagPatientModel(
      lastName: action.patientData.lastName ?? currentPatient.lastName,
      firstName: action.patientData.firstName ?? currentPatient.firstName,
      appointments: action.patientData.appointments ?? currentPatient,
    );
  }
  if (action is DeletePatientDataAction) {
    if (currentPatient.id == action.patientId) return null;
  }

  return currentPatient;
}
