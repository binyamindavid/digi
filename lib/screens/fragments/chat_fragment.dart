import 'dart:async';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/cupertino.dart';

class ChatFragment extends StatefulWidget {
  @override
  _ChatFragmentState createState() => _ChatFragmentState();
}

class _ChatFragmentState extends State<ChatFragment> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  final ChatUser user = ChatUser(
    name: "Fayeed",
    uid: "123456789",
    avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
  );

  final ChatUser otherUser = ChatUser(
    name: "Mrfatty",
    uid: "25649654",
  );

  List<ChatMessage> messages = List<ChatMessage>();

  var m = List<ChatMessage>();

  var i = 0;

  @override
  void initState() {
    super.initState();

    messages.addAll([
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
    ]);
  }

  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState.scrollController
          ..animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }

  void onSend(ChatMessage message) {
    print(message.toJson());
    // var documentReference = Firestore.instance
    //     .collection('messages')
    //     .document(DateTime.now().millisecondsSinceEpoch.toString());

    // Firestore.instance.runTransaction((transaction) async {
    //   await transaction.set(
    //     documentReference,
    //     message.toJson(),
    //   );
    // });
    setState(() {
      messages = [...messages, message];
      print(messages.length);
    });

    if (i == 0) {
      systemMessage();
      Timer(Duration(milliseconds: 600), () {
        systemMessage();
      });
    } else {
      systemMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
