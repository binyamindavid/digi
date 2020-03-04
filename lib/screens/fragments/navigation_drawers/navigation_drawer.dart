import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

import '../../../auth_service.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key key, this.dragUpdate: 0, this.isSignedIn: false})
      : super(key: key);
  final double dragUpdate;
  final isSignedIn;
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
                colors: [
                  ColorTween(
                    begin: Colors.blue,
                    end: Colors.blue,
                  ).lerp(dragUpdate),
                  ColorTween(
                    begin: Colors.blue,
                    end: Colors.red,
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
                                  color: Colors.blue[50],
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            Text(
                              "Yohanne Smit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                          //mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        //Padding(
                          //padding: EdgeInsets.all(10),
                        //),
                        // Material(
                        //   color: Colors.transparent,
                        //   child: InkWell(
                        //       onTap: () => print("Rate us"),
                        //       child: ListTile(
                        //           title: Text(
                        //             "Rate",
                        //             style: TextStyle(
                        //                 color: Colors.white, fontSize: 14),
                        //           ),
                        //           leading: Icon(
                        //             hasRated
                        //                 ? LineAwesomeIcons.star
                        //                 : LineAwesomeIcons.star_o,
                        //             color: Colors.white,
                        //             size: 22,
                        //           ))),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
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
                        // Material(
                        //   color: Colors.transparent,
                        //   child: InkWell(
                        //       onTap: () => print("Settings"),
                        //       child: ListTile(
                        //           title: Text(
                        //             "Settings",
                        //             style: TextStyle(
                        //                 color: Colors.white, fontSize: 14),
                        //           ),
                        //           leading: Icon(
                        //             LineAwesomeIcons.cog,
                        //             color: Colors.white,
                        //             size: 22,
                        //           ))),
                        // ),
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
                                    "Support",
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
                                            "Sign Out",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          leading: Icon(
                                            Icons.exit_to_app,
                                            color: Colors.white,
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
