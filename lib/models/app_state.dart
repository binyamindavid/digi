import 'package:dash_chat/dash_chat.dart';
import 'package:digamobile/models/api_specific_models/diga_api_patient_model.dart';
import 'package:digamobile/models/clinic_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppState {
  final int count;
  final bool isLoading;
  final FirebaseUser currentUser;
  final DiagPatientModel patientData;
  final List<ClinicModel> clinics;
  final List<ChatMessage> messages;

  AppState(
      {this.messages,
      this.patientData,
      this.count = 0,
      this.isLoading = false,
      this.currentUser,
      this.clinics});
  AppState copyWith({int count, bool isLoading}) {
    return new AppState(
      count: count ?? this.count,
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
      clinics: clinics ?? this.clinics,
      patientData: patientData ?? this.patientData,
      messages: messages ?? this.messages,
    );
  }

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, count: $count, currentUser: $currentUser, clinics: $clinics, patientData: ${patientData}}';
  }
}
