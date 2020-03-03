import 'package:digamobile/screens/fragments/navigation_drawers/navigation_drawer.dart';
import 'package:digamobile/screens/fragments/templates/destination_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

import 'home_page.dart';

class AppBase extends StatefulWidget {
  AppBase({Key key, this.isLoggedIn}) : super(key: key);
  final isLoggedIn;
  @override
  _AppBaseState createState() => _AppBaseState();
}

class _AppBaseState extends State<AppBase> with TickerProviderStateMixin {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  bool _onTapToClose = false;
  bool _swipe = true;
  bool _tapScaffold = true;
  bool _isChatEnabled = true;
  InnerDrawerAnimation _animationType = InnerDrawerAnimation.static;
  double _offset = 0.4;

  AnimationController _controller;
  Animation<double> _drawerState;

  double _dragUpdate = 0;
  int _index = 0;
  InnerDrawerDirection _direction = InnerDrawerDirection.start;

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Colors.black54;
  ValueChanged<Color> onColorChanged;

//navigation state
  List<AnimationController> _faders;
  List<Key> _destinationKeys;

  // Custom navigator takes a global key if you want to access the
  // navigator from outside it's widget tree subtree
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    print("@@@@----MAIN____APPP____INIT___STATE");
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _drawerState = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addListener(() {
      print("animating ${_drawerState.value}");

      print("Clicked");
      _direction = InnerDrawerDirection.start;
      setState(() => _dragUpdate = _drawerState.value);
    });
    _drawerState.addListener(() {
      setState(() {
        print("Clicked");
        this._dragUpdate = _drawerState.value;
      });
    });
    _faders =
        allDestinations.map<AnimationController>((PageDestination destination) {
      return AnimationController(
          vsync: this, duration: Duration(milliseconds: 500));
    }).toList();
    _faders[_index].value = 1.0;
    _destinationKeys =
        List<Key>.generate(allDestinations.length, (int index) => GlobalKey())
            .toList();

    super.initState();
  }

  @override
  void dispose() {
    for (AnimationController controller in _faders) controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InnerDrawer(
        key: _innerDrawerKey,
        onTapClose: _onTapToClose,
        tapScaffoldEnabled: _tapScaffold,

        offset: IDOffset.horizontal(_offset),
        swipe: _swipe,
        boxShadow: _direction == InnerDrawerDirection.start &&
                _animationType == InnerDrawerAnimation.linear
            ? []
            : null,
        colorTransition: currentColor,
        leftAnimationType: _animationType,
        rightAnimationType: InnerDrawerAnimation.linear,
        leftChild: NavigationDrawer(
          dragUpdate: _dragUpdate,
          isSignedIn: widget.isLoggedIn,
        ),

        //rightChild: MapFilterDrawer(),

        onDragUpdate: (double val, InnerDrawerDirection direction) {
          _direction = direction;
          setState(() => _dragUpdate = val);
        },
        //innerDrawerCallback: (a) => print(a),
        scaffold: Scaffold(
            floatingActionButton: _isChatEnabled
                ? null
                : FloatingActionButton.extended(
                    onPressed: () {},
                    label: Text("Appointment"),
                    icon: Icon(
                      Icons.add,
                      color: allDestinations[_index].materialColorLight,
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            extendBody: false,
            bottomNavigationBar: BottomNavigationBar(
              //type: BottomNavigationBarType.fixed,
              selectedIconTheme: IconThemeData(size: 26),
              selectedItemColor: allDestinations[_index].materialColor,
              unselectedItemColor: Colors.grey.shade900,
              showUnselectedLabels: true,
              onTap: (index) {
                // navigatorKey.currentState.maybePop();
                setState(() => _index = index);
              },
              currentIndex: _index,
              items: allDestinations
                  .map<BottomNavigationBarItem>((pageDestination) {
                return BottomNavigationBarItem(
                    icon: Icon(pageDestination.icon),
                    activeIcon: Icon(pageDestination.activeIcon),
                    backgroundColor: pageDestination.materialColor,
                    title: Text(pageDestination.title));
              }).toList(),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: allDestinations.map((PageDestination destination) {
                final Widget view = FadeTransition(
                  opacity: _faders[destination.index]
                      .drive(CurveTween(curve: Curves.fastOutSlowIn)),
                  child: KeyedSubtree(
                    key: _destinationKeys[destination.index],
                    child: _index == 0
                        ? HomePage(
                            "Welcome",
                            menuClicked: () {
                              print("clicked in base");
                              _controller.status == AnimationStatus.completed ||
                                      _controller.status ==
                                          AnimationStatus.reverse
                                  ? _controller.forward()
                                  : _controller.reverse();
                              _controller.forward();
                            },
                          )
                        : DestinationView(
                            destination: destination,
                          ),
                  ),
                );
                if (destination.index == _index) {
                  _faders[destination.index].forward();
                  return view;
                } else {
                  _faders[destination.index].reverse();
                  if (_faders[destination.index].isAnimating) {
                    return IgnorePointer(child: view);
                  }
                  return Offstage(child: view);
                }
              }).toList(),
            )),
      ),
    );
  }
}
