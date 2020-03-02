//import 'package:digamobile/actions/auth_actions.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';

class AuthService {
  // Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Sign in
  signIn(String email, String password,
      Function(FirebaseUser) onLoginSuccessful, Function(dynamic) onError) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      onLoginSuccessful(user.user);
      print('Signed in');
    }).catchError((e) {
      onError(e);
      print(e);
    });
  }
}