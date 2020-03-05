import 'package:digamobile/models/app_state.dart';
import 'package:digamobile/reducers/auth_reducer.dart';
import 'package:digamobile/reducers/counter_reducer.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: false,
    count: counterReducer(state.count, action),
    currentUser: authReducer(state.currentUser, action),
    patientData: patientReducer(state.patientData, action),
  );
}
