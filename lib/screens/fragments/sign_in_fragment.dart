import 'package:digamobile/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigninFragment extends StatefulWidget {
  final Function(FirebaseUser) onLoginSuccessful;
  final Function() onLoginPressed;

  const SigninFragment({Key key, this.onLoginSuccessful, this.onLoginPressed})
      : super(key: key);

  @override
  _SigninFragmentState createState() => _SigninFragmentState();
}

class _SigninFragmentState extends State<SigninFragment> {
  String email, password;
  bool hasError = false;

  final formKey = new GlobalKey<FormState>();

  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      return true;
    } else
      return false;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          //height: 250.0,
          width: 400.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              !hasError
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Error Logging in",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
              !hasError
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Please check email or password!",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 20.0, bottom: 5.0),
                      child: Container(
                        height: 120.0,
                          child: Image.asset('images/diga_logo.png', width: 140, fit: BoxFit.cover)
                      ),

                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 20.0, bottom: 5.0),
                        child: Container(
                          height: 50.0,
                          child: TextFormField(
                            decoration: InputDecoration(hintText: 'Email'),
                            validator: (value) => value.isEmpty
                                ? 'Email is required'
                                : validateEmail(value.trim()),
                            onChanged: (value) {
                              this.email = value;
                            },
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 20.0, bottom: 5.0),
                        child: Container(
                          height: 50.0,
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(hintText: 'Password'),
                            validator: (value) =>
                                value.isEmpty ? 'Password is required' : null,
                            onChanged: (value) {
                              this.password = value;
                            },
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: Colors.blue,
                        elevation: 0.0,
                        onPressed: () {
                          if (checkFields()) {
                            AuthService().signIn(email, password,
                                widget.onLoginSuccessful, _onError);
                          }
                        },
                        child: Container(
                          height: 40.0,
                          width: 300.0,
                          child: Center(
                              child: Text(
                            'Sign in ',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onError(error) {
    if (mounted) {
      setState(() {
        hasError = true;
      });
    }
  }
}
