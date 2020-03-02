import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

import '../../../auth_service.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key key, this.dragUpdate: 0}) : super(key: key);
  final double dragUpdate;
  final availableSos = false;
  final isSignedIn = false;
  final hasRated = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
          child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                // Add one stop for each color. Stops should increase from 0 to 1
                //stops: [0.1, 0.5,0.5, 0.7, 0.9],
                colors: [
                  ColorTween(
                    begin: Colors.blueAccent,
                    end: Colors.blueGrey[400].withRed(100),
                  ).lerp(dragUpdate),
                  ColorTween(
                    begin: Colors.green,
                    end: Colors.blueGrey[800].withGreen(80),
                  ).lerp(dragUpdate),
                ],
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left: 10, bottom: 15, top: 72),
                              width: 80,
                              child: ClipRRect(
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  color: Colors.blueAccent,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            Text(
                              "User",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                          //mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () => print("Rate us"),
                              child: ListTile(
                                  title: Text(
                                    "Rate",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  leading: Icon(
                                    hasRated
                                        ? LineAwesomeIcons.star
                                        : LineAwesomeIcons.star_o,
                                    color: Colors.white,
                                    size: 22,
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Material(
                          color: availableSos
                              ? Colors.red[800]
                              : Colors.red.shade900.withAlpha(150),
                          child: InkWell(
                              onTap: () => print("Sos"),
                              child: ListTile(
                                  title: Text(
                                    "S.O.S",
                                    style: TextStyle(
                                        color: availableSos
                                            ? Colors.white
                                            : Colors.grey.shade300,
                                        fontSize: 14),
                                  ),
                                  trailing: availableSos
                                      ? Icon(
                                          Icons.adjust,
                                          color: Colors.green[300],
                                        )
                                      : Icon(
                                          Icons.album,
                                          color: Colors.red[700].withAlpha(150),
                                        ),
                                  leading: Icon(
                                    LineAwesomeIcons.exclamation_triangle,
                                    //FontAwesomeIcons.exclamationTriangle,
                                    color: Colors.white,
                                    size: 22,
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () => print("My Account"),
                              child: ListTile(
                                  title: Text(
                                    "My Account",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  leading: Icon(
                                    LineAwesomeIcons.lock,
                                    color: Colors.white,
                                    size: 22,
                                  ))),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () => print("Settings"),
                              child: ListTile(
                                  title: Text(
                                    "Settings",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  leading: Icon(
                                    LineAwesomeIcons.cog,
                                    color: Colors.white,
                                    size: 22,
                                  ))),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () => print("Help"),
                              child: ListTile(
                                  title: Text(
                                    "Help",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  leading: Icon(
                                    LineAwesomeIcons.info_circle,
                                    color: Colors.white,
                                    size: 22,
                                  ))),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () => print("Contact us"),
                              child: ListTile(
                                  title: Text(
                                    "Contact",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  leading: Icon(
                                    Icons.mail_outline,
                                    color: Colors.white,
                                    size: 22,
                                  ))),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 24.0, bottom: 24.0),
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        isSignedIn
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () => AuthService().signOut(),
                                      child: ListTile(
                                          title: Text(
                                            "Logout",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16),
                                          ),
                                          leading: Icon(
                                            Icons.exit_to_app,
                                            color: Colors.grey,
                                            size: 22,
                                          ))),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () => print("Sign in"),
                                      child: ListTile(
                                          title: Text(
                                            "Log in",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          leading: Icon(
                                            Icons.person_outline,
                                            color: Colors.white,
                                            size: 22,
                                          ))),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          dragUpdate < 1
              ? BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: (10 - dragUpdate * 10),
                      sigmaY: (10 - dragUpdate * 10)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                )
              : null,
        ].where((a) => a != null).toList(),
      )),
    );
  }
}
