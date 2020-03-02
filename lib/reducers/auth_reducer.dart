import 'package:digamobile/actions/auth_actions.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseUser authReducer(FirebaseUser currentUser, action) {
  if (action is SaveInformationOnLogin) {
    //Only saving, do nothing
    return action.payload;
  } else {
    return currentUser;
  }
}