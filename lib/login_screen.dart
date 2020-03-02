import 'package:digamobile/actions/auth_actions.dart';
import 'package:digamobile/models/app_state.dart';
import 'package:digamobile/screens/fragments/sign_in_fragment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnProfileSaveCallback>(
      converter: (Store<AppState> store) {
        return (user) {
          store.dispatch(new SaveInformationOnLogin(payload: user));
        };
      },
      builder: (BuildContext context, OnProfileSaveCallback save) {
        return new SigninFragment(onLoginSuccessful: (user) {
          save(user);
        });
      },
    );
  }
}

typedef OnProfileSaveCallback = Function(FirebaseUser user);