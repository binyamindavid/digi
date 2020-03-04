import 'package:digamobile/screens/fragments/chat_fragment.dart';
import 'package:digamobile/screens/fragments/templates/destination_view.dart';
import 'package:digamobile/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String title;
  //Call back to pass menu click event to the app base to open the app drawer
  final VoidCallback menuClicked;
  final PageDestination destination;

  HomePage(
    this.title, {
    this.menuClicked,
    this.destination,
  });

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
                  menuClicked: () {
                    print("Clicked in home");
                    this.menuClicked.call();
                  },
                );
              case ConstantsRoutes.HOME_CHAT_PAGE:
                return ChatFragment(
                  destination: destination,
                );
            }
          },
        );
      },
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({
    Key key,
    this.title,
    this.menuClicked,
    this.destination,
  }) : super(key: key);
  final String title;
  //Call back to pass menu click event to the app base to open the app drawer
  final VoidCallback menuClicked;

  final PageDestination destination;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: new CupertinoNavigationBar(
        automaticallyImplyMiddle: true,
        middle: Text(
          this.title,
          style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
        ),
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Material(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.grey.shade900,
                ),
                onPressed: () {
                  this.menuClicked.call();
                }),
          ),
        ),
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You are logged in'),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
      //floatingActionButton: new IncreaseCountButton());
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ConstantsRoutes.HOME_CHAT_PAGE);
        },
        child: Icon(Icons.chat),
        backgroundColor: Colors.orange,
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
