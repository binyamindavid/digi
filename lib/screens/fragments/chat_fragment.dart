import 'dart:async';
import 'dart:io';
import 'package:digamobile/models/app_state.dart';
import 'package:digamobile/services/call_api_service.dart';
import 'package:digamobile/services/chatbot_service_config.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:digamobile/screens/fragments/templates/destination_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
//import 'package:image_picker/image_picker.dart';

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

  // Future getImage() async {
  //   // PermissionStatus permissionResult =
  //   //     await SimplePermissions.requestPermission(
  //   //         Permission.WriteExternalStorage);
  //   // if (permissionResult == PermissionStatus.authorized) {
  //   //   // code of read or write file in external storage (SD card)

  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _image = image;
  //   });
  //   //}
  // }

  ChatbotServiceConfig _chatConfig;

  ChatUser user;

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

        ///Instantiates the messages if they are empty
        if (messages == null) {
          messages = [];
        }

        //Adds a message directly to the message stack if there are no other messages
        if (messages.length < 1) {
          systemMessage(message.message, message.delayMilliSeconds);
          return;
        }
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
    _chatConfig.chatBotNotifyMessageStream.listen((event) {
      print("@@@@@___________ Snapshot data ${event}_________@@@@");
      setState(() {
        this.isTyping = true;
      });
    });
  }

  bool isTyping = false;
  void systemMessage(message, duration) async {
    print("Adding message $message duration = $duration");

    Timer(Duration(milliseconds: duration ?? 0), () {
      if (mounted)
        setState(() {
          messages = [...messages, message];
          isTyping = false;
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

  void onSend(ChatMessage message, {store}) {
    print(message.toJson());
    _chatConfig.sendMessage(message, store: store);

    setState(() {
      //messages = [...messages, message];
      messages = []
        ..addAll(messages)
        ..add(message);
      print(messages.length);
    });
  }

  ///Set this [bool] flag to true to target ios changes- change it to false to targt android
  ///the value can be set using target platform in the production version
  bool _isIos = true;

  CallApi _callApi;

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    if (_callApi == null) {
      _callApi = CallApi(store: store);
    }
    _chatConfig.set(store);

    if (user == null)
      user = ChatUser(
          name: store.state.patientData != null
              ? store.state.patientData.firstName != "" &&
                      store.state.patientData.lastName != ""
                  ? '${store.state.patientData.firstName ?? ""} ${store.state.patientData.lastName ?? ""}'
                  : "No patient record"
              : "Patient",
          uid: "123456789",
          avatar:
              "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
          color: Colors.white,
          containerColor: Colors.deepPurpleAccent);
    return Scaffold(
      extendBody: false,
      appBar: _isIos
          ?

          ///Returns an [CupertinoNavigationBar] styled for the IOS platform
          CupertinoNavigationBar(
              backgroundColor: Colors.white,
              middle: Text(
                "DiGA Assistant",
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
              automaticallyImplyMiddle: true,
              automaticallyImplyLeading: true,
              leading: Container(
                constraints: BoxConstraints(maxWidth: 80),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        if (!_chatConfig.sentMessagesFlag)
                          _callApi.postMessages(store.state.currentUser.email);

                        ///Dispose of the message streams and sinks as they are no longer needed
                        _chatConfig.dispose();
                        _callApi.dispose();
                        if (Navigator.of(context).canPop())
                          Navigator.of(context).pop();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            CupertinoIcons.back,
                            color: Colors.blue,
                            size: 22,
                          ),
                          Text(
                            "back",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          :

          ///Returns an [AppBar] styled for the android platform
          AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "DiGA Assistant",
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              centerTitle: true,
              automaticallyImplyLeading: true,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey.shade800,
                  ),
                  onPressed: () {
                    if (!_chatConfig.sentMessagesFlag)
                      _callApi.postMessages(store.state.currentUser.email);

                    ///Dispose of the message streams and sinks as they are no longer needed
                    _chatConfig.dispose();
                    _callApi.dispose();
                    if (Navigator.of(context).canPop())
                      Navigator.of(context).pop();
                  }),
            ),
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: DashChat(
                  height: MediaQuery.of(context).size.height - 120.0,
                  key: _chatViewKey,
                  inverted: false,
                  onSend: (message) {
                    onSend(message, store: store);
                  },
                  user: user,
                  inputDecoration:
                      InputDecoration(hintText: "Please type here ..."),
                  dateFormat: DateFormat('dd-MMM-yyyy'),
                  timeFormat: DateFormat('HH:mm'),
                  messages: messages,
                  showUserAvatar: false,
                  showAvatarForEveryMessage: false,
                  scrollToBottom: true,
                  onPressAvatar: (ChatUser user) {
                    print("OnPressAvatar: ${user.name}");
                  },
                  onLongPressAvatar: (ChatUser user) {
                    print("OnLongPressAvatar: ${user.name}");
                  },
                  inputMaxLines: 5,
                  alwaysShowSend: false,
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
                        text: reply.title,
                        createdAt: DateTime.now(),
                        user: user));
                  },
                  onLoadEarlier: () {
                    print("laoding...");
                  },
                  shouldShowLoadEarlier: false,
                  showTraillingBeforeSend: true,
                ),
              ),
            ],
          ),
          isTyping
              ? Positioned(
                  top: 0,
                  left: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Assistant is typing ...",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ))
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }
}
