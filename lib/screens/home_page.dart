import 'package:digamobile/auth_service.dart';
import 'package:digamobile/containers/counter/counter.dart';
import 'package:digamobile/containers/counter/increase_counter.dart';
import 'package:digamobile/screens/fragments/chat_fragment.dart';
import 'package:digamobile/screens/fragments/templates/destination_view.dart';
import 'package:digamobile/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String title;
  //Call back to pass menu click event to the app base to open the app drawer
  final Function() MenuClicked;
  final PageDestination destination;

  HomePage(this.title, this.MenuClicked, {this.destination});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case ConstantsRoutes.HOME_ROOT_PAGE:
                return _HomeScreen(
                  destination: destination,
                  title: title,
                );
              case ConstantsRoutes.HOME_CHAT_PAGE:
                return ChatFragment(destination: destination);
            }
          },
        );
      },
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key key, this.title, this.menuClicked, this.destination})
      : super(key: key);
  final String title;
  //Call back to pass menu click event to the app base to open the app drawer
  final Function() menuClicked;
  final PageDestination destination;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          this.title,
          style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.grey.shade900,
            ),
            onPressed: () {}),
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
      //floatingActionButton: new IncreaseCountButton());
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(ConstantsRoutes.HOME_CHAT_PAGE),
        child: Icon(Icons.chat),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
