import 'package:digamobile/models/app_state.dart';
import 'package:digamobile/reducers/app_state_reducer.dart';
import 'package:digamobile/screens/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  final title = 'DiGi Web';
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(),
    middleware: []..add(new LoggingMiddleware.printer()),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        home: new AuthenticationService(title: title),
      ),
    );
  }
}
//Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
