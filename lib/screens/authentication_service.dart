import 'package:digamobile/actions/auth_actions.dart';
import 'package:digamobile/login_screen.dart';
import 'package:digamobile/models/app_state.dart';
import 'package:digamobile/screens/app_base_screen.dart';
import 'package:digamobile/screens/home_page.dart';
import 'package:digamobile/services/call_api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AuthenticationService extends StatelessWidget {
  final title;

  const AuthenticationService({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          initialData: null,
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              FirebaseUser data = snapshot.data;
              print(data.email);

              var store = StoreProvider.of<AppState>(context);
              print("@@@@@----username from firebase ${data.toString()}");
              store.dispatch(SaveInformationOnLogin(payload: data));

              CallApi _apiPatientData = CallApi();
              _apiPatientData.getPatientDetail(data.email, store: store);

              return AppBase(
                isLoggedIn: true,
              );
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
