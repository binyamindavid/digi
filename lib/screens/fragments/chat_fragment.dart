import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:digamobile/screens/fragments/templates/destination_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatFragment extends StatefulWidget {
  final PageDestination destination;

  const ChatFragment({
    Key key,
    this.destination,
  }) : super(key: key);
  @override
  _ChatFragmentState createState() => _ChatFragmentState();
}

class _ChatFragmentState extends State<ChatFragment> {
  @override
  Future<void> initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url:
          "https://webchat.snatchbot.me/e30deda7335903ce072120872201193e4e9dac8004f8f2c770a6e3cb297bf8de",
      appBar: new AppBar(
        title: const Text('Diga Assistant'),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild:
          Center(child: Container(child: CircularProgressIndicator())),
    );
  }
}
