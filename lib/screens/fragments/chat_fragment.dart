import 'dart:async';
import 'dart:io';
import 'package:digamobile/models/app_state.dart';
import 'package:digamobile/services/chatbot_service_config.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:digamobile/screens/fragments/templates/destination_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  File _image;

  Future getImage() async {
    // PermissionStatus permissionResult =
    //     await SimplePermissions.requestPermission(
    //         Permission.WriteExternalStorage);
    // if (permissionResult == PermissionStatus.authorized) {
    //   // code of read or write file in external storage (SD card)

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
    //}
  }

  ChatbotServiceConfig _chatConfig;

  final ChatUser user = ChatUser(
      name: "Fayeed",
      uid: "123456789",
      avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
      color: Colors.white,
      containerColor: Colors.deepPurpleAccent);

  final ChatUser otherUser = ChatUser(
    name: "Mrfatty",
    uid: "25649654",
  );

  List<ChatMessage> messages = List<ChatMessage>();

  var m = List<ChatMessage>();

  var i = 0;

  _onMessageReceived(message) {
    if (message != null) {
      if (message is ChatUiMessage) {
        print(
            "@@@@@___________ Snapshot data ${message.message.text}_________@@@@");

        //Update the messages only if there are new messages
        if (message.message.id != messages.last.id) {
          systemMessage(message.message, message.delayMilliSeconds);
          //messages = [...messages, message.message];
        }
      }
    }
  }

  @override
  void dispose() {
    _chatConfig.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();

    _chatConfig = ChatbotServiceConfig(
      'https://account.snatchbot.me/channels/api/api/id94441/appcom.moozenhq.digamobile/apsF58DCEC4F87FBF5BFADE9F5D56F91',
    );

    _chatConfig.chatBotMessageStream.listen(_onMessageReceived);
    messages.addAll([
      ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      // ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      // ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      // ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      // ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      // ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      // ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
      // ChatMessage(text: "hello", user: user, createdAt: DateTime.now()),
    ]);
  }

  void systemMessage(message, duration) async {
    print("Adding message $message");
    Timer(Duration(milliseconds: duration), () {
      if (mounted)
        setState(() {
          messages = [...messages, message];
        });

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
    _chatConfig.sendMessage(message);

    setState(() {
      //messages = [...messages, message];
      messages = []
        ..addAll(messages)
        ..add(message);
      print(messages.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppState store = StoreProvider.of<AppState>(context).state;
    _chatConfig.set(store);
    return Scaffold(
      extendBody: false,
      appBar: CupertinoNavigationBar(
        automaticallyImplyMiddle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () {
              ///Dispose of the message streams and sinks as they are no longer needed
              _chatConfig.dispose();
              if (Navigator.of(context).canPop()) Navigator.of(context).pop();
            }),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: DashChat(
              height: MediaQuery.of(context).size.height - 120.0,
              key: _chatViewKey,
              inverted: false,
              onSend: onSend,
              user: user,
              inputDecoration: InputDecoration(hintText: "Add message here..."),
              dateFormat: DateFormat('dd-MMM-yyyy'),
              timeFormat: DateFormat('HH:mm'),
              messages: messages,
              showUserAvatar: true,
              showAvatarForEveryMessage: false,
              scrollToBottom: true,
              onPressAvatar: (ChatUser user) {
                print("OnPressAvatar: ${user.name}");
              },
              onLongPressAvatar: (ChatUser user) {
                print("OnLongPressAvatar: ${user.name}");
              },
              inputMaxLines: 5,
              alwaysShowSend: true,
              inputTextStyle: TextStyle(fontSize: 16.0),
              inputToolbarPadding: EdgeInsets.only(left: 8.0),
              inputToolbarMargin: EdgeInsets.all(4.0),
              inputContainerStyle: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 0.3, color: Colors.black),
                color: Colors.white,
              ),
              messageContainerDecorationRecepient: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              messageContainerDecoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              quickReplyStyle: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.3, color: Colors.black),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              quickReplyTextStyle: TextStyle(fontSize: 16),
              onQuickReply: (Reply reply) {
                onSend(ChatMessage(
                    text: reply.title, createdAt: DateTime.now(), user: user));
              },
              onLoadEarlier: () {
                print("laoding...");
              },
              shouldShowLoadEarlier: false,
              showTraillingBeforeSend: true,
              trailing: <Widget>[
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () async {
                    File result = await ImagePicker.pickImage(
                      source: ImageSource.gallery,
                      maxHeight: 400,
                      maxWidth: 400,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
