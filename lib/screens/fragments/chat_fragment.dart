import 'dart:async';
import 'dart:io';

import 'package:dash_chat/dash_chat.dart';
import 'package:digamobile/screens/fragments/templates/destination_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_permissions/simple_permissions.dart';

class ChatFragment extends StatefulWidget {
  final PageDestination destination;

  const ChatFragment({Key key, this.destination}) : super(key: key);
  @override
  _ChatFragmentState createState() => _ChatFragmentState();
}

class _ChatFragmentState extends State<ChatFragment> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  File _image;

  Future getImage() async {
    PermissionStatus permissionResult =
        await SimplePermissions.requestPermission(
            Permission.WriteExternalStorage);
    if (permissionResult == PermissionStatus.authorized) {
      // code of read or write file in external storage (SD card)

      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }
  }

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
          //messages = [...messages, m[i]];
          messages = []
            ..addAll(messages)
            ..add(m[i]);
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
      //messages = [...messages, message];
      messages = []
        ..addAll(messages)
        ..add(message);
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
    return Scaffold(
      appBar: CupertinoNavigationBar(),
      body: DashChat(
        height: MediaQuery.of(context).size.height - 60.0,
        key: _chatViewKey,
        inverted: false,
        onSend: onSend,
        user: user,
        inputDecoration:
            InputDecoration.collapsed(hintText: "Add message here..."),
        dateFormat: DateFormat('yyyy-MMM-dd'),
        timeFormat: DateFormat('HH:mm'),
        messages: messages,
        showUserAvatar: true,
        showAvatarForEveryMessage: false,
        scrollToBottom: true,
        // inputFooterBuilder: () {
        //   return Column(
        //     children: [
        //       Text('asd'),
        //       Text('asd'),
        //       Text('asd'),
        //       Text('asd'),
        //       Text('asd'),
        //       Text('asd'),
        //     ],
        //   );
        // },
        onPressAvatar: (ChatUser user) {
          print("OnPressAvatar: ${user.name}");
        },
        onLongPressAvatar: (ChatUser user) {
          print("OnLongPressAvatar: ${user.name}");
        },
        inputMaxLines: 5,
        alwaysShowSend: true,
        inputTextStyle: TextStyle(fontSize: 16.0),
        inputContainerStyle: BoxDecoration(
          border: Border.all(width: 0.0),
          color: Colors.white,
        ),
        onQuickReply: (Reply reply) {
          setState(() {
            messages.add(ChatMessage(
                text: reply.value, createdAt: DateTime.now(), user: user));

            messages = []..addAll(messages);
          });

          Timer(Duration(milliseconds: 300), () {
            _chatViewKey.currentState.scrollController
              ..animateTo(
                _chatViewKey
                    .currentState.scrollController.position.maxScrollExtent,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );

            if (i == 0) {
              systemMessage();
              Timer(Duration(milliseconds: 600), () {
                systemMessage();
              });
            } else {
              systemMessage();
            }
          });
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

              // if (result != null) {
              //   final StorageReference storageRef =
              //       FirebaseStorage.instance.ref().child("chat_images");

              //   StorageUploadTask uploadTask = storageRef.putFile(
              //     result,
              //     StorageMetadata(
              //       contentType: 'image/jpg',
              //     ),
              //   );
              //   StorageTaskSnapshot download =
              //       await uploadTask.onComplete;

              //   String url = await download.ref.getDownloadURL();

              //   ChatMessage message =
              //       ChatMessage(text: "", user: user, image: url);

              //   var documentReference = Firestore.instance
              //       .collection('messages')
              //       .document(
              //           DateTime.now().millisecondsSinceEpoch.toString());

              //   Firestore.instance.runTransaction((transaction) async {
              //     await transaction.set(
              //       documentReference,
              //       message.toJson(),
              //     );
              //   });
              // }
            },
          )
        ],
      ),
    );
  }
}
