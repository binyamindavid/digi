import 'package:digamobile/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class DestinationView extends StatefulWidget {
  DestinationView({Key key, this.destination}) : super(key: key);
  final PageDestination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class PageDestination {
  final index;
  final String title;
  final IconData icon;
  final IconData activeIcon;
  final MaterialColor materialColor;
  final Color materialColorLight;

  const PageDestination(
      this.title, this.materialColor, this.icon, this.activeIcon, this.index,
      {this.materialColorLight: Colors.white});
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return RootPage(destination: widget.destination);
              case '/list':
                return ListPage(destination: widget.destination);
              case '/text':
                return TextPage(destination: widget.destination);
            }
          },
        );
      },
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({Key key, this.destination}) : super(key: key);

  final PageDestination destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destination.title),
        backgroundColor: destination.materialColor,
      ),
      backgroundColor: destination.materialColor[50],
      body: SizedBox.expand(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/list");
          },
        ),
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({Key key, this.destination}) : super(key: key);

  final PageDestination destination;

  @override
  Widget build(BuildContext context) {
    const List<int> shades = <int>[
      50,
      100,
      200,
      300,
      400,
      500,
      600,
      700,
      800,
      900
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(destination.title),
        backgroundColor: destination.materialColor,
      ),
      backgroundColor: destination.materialColor[50],
      body: SizedBox.expand(
        child: ListView.builder(
          itemCount: shades.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 128,
              child: Card(
                color:
                    destination.materialColor[shades[index]].withOpacity(0.25),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/text");
                  },
                  child: Center(
                    child: Text('Item $index',
                        style: Theme.of(context).primaryTextTheme.display1),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TextPage extends StatefulWidget {
  const TextPage({Key key, this.destination}) : super(key: key);

  final PageDestination destination;

  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: 'sample text: ${widget.destination.title}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.destination.title),
        backgroundColor: widget.destination.materialColor,
      ),
      backgroundColor: widget.destination.materialColor[50],
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: Alignment.center,
        child: TextField(controller: _textController),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

//The destination information for the bottom navigation
List<PageDestination> allDestinations = <PageDestination>[
  PageDestination('Home', Colors.blue, CupertinoIcons.home, Icons.home,
      Constants.HOME_MAIN_PAGE),
  PageDestination('Appointments', Colors.blue, CupertinoIcons.book,
      CupertinoIcons.book_solid, Constants.APPOINTMENTS_MAIN_PAGE),
];
