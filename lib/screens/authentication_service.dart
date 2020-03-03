import 'package:digamobile/login_screen.dart';
import 'package:digamobile/screens/app_base_screen.dart';
import 'package:digamobile/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
