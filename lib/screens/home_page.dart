import 'package:digamobile/auth_service.dart';
import 'package:digamobile/containers/counter/counter.dart';
import 'package:digamobile/containers/counter/increase_counter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: new AppBar(
          title: new Text(this.title),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: new Container(
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('You are logged in'),
                SizedBox(height: 10.0),
                RaisedButton(
                  onPressed: () {
                    AuthService().signOut();
                  },
                  child: Center(
                    child: Text('Sign Out'),
                  ),
                  color: Colors.red,
                ),
                new Text(
                  'You have pushed the button this many times:',
                ),
                new Counter(),
              ],
            ),
          ),
        ),
        floatingActionButton: new IncreaseCountButton());
  }
}