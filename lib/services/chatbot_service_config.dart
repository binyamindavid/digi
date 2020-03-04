import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digamobile/models/api_specific_models/snatchbot_message_response_model.dart';
import 'package:digamobile/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:dash_chat/dash_chat.dart';

class ChatbotServiceConfig {
  ChatbotServiceConfig(this.endPointUrl,
      {this.store,
      this.chatbotAvatarLink:
          "https://dvgpba5hywmpo.cloudfront.net/media/image/yfYvrEPJjnR3rGpZiC6BMLRKu"}) {
    if (client == null) client = http.Client();

    //Initialise the bot user
    _botUser = ChatUser(
        uid: "dg-bot01",
        name: "Diga-Bot",
        containerColor: Colors.white,
        color: Colors.blue.shade800,
        avatar: chatbotAvatarLink);

        emitNewMessage(new ChatUiMessage(message: ChatMessage(text: "Welcome to DiGA assistant. Please type to proceed", user: _botUser, createdAt: DateTime.now())));
  }

  ///A reference to the global redux [AppState] store to retrieve username and other config values
  ///Cannot be null
  AppState store;
  String chatbotAvatarLink;

  set(state) => store;

  ///The [ChatUser] reference for the chatbot to display in the chat ui
  ChatUser _botUser;

  ///Add the requred params for the conversation stream
  ///The [user_id] should be unique
  String userId = "Fjorde_${DateTime.now().millisecondsSinceEpoch}";

  ///[message_id] only used when continuing a chat from a different platform,
  ///default to 0
  int messageId = 0;
  //api endpoint url, should be passed into the build proccess on the final build
  //for now, will be hard coded.
  final endPointUrl;
  http.Client client;

  ///[StreamController] Controls the stream and Sink for [ChatUiMessage] api

  StreamController<ChatUiMessage> _apiStreamController =
      StreamController<ChatUiMessage>();

  ///[chatBotMessageStream] is a [Stream]that will be subscribed to by any listeners
  ///emmits messages from this api that are passed into the internal [StreamSink]
  Stream get chatBotMessageStream => _apiStreamController.stream;

  ///[_internalMessageStreamSink] is the internal  [StreamSink]
  ///that is used to pass data to all listeners
  StreamSink get _internalMessageStreamSink => _apiStreamController.sink;

  sendMessage(ChatMessage message,
      {String url:
          'https://account.snatchbot.me/channels/api/api/id92285/appmoozenhq/apseyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'}) async {
    if (message.text != null) {
      print("Output @@@ ${message.text}");
      try {
        var urlEP =
            '${url}?user_id=${this.userId}&message_id=${this.messageId}';

        var request = new http.Request('POST', Uri.parse(urlEP));
        var body = json.encode({'message': message.text});
        request.headers[HttpHeaders.contentTypeHeader] =
            'application/json; charset=utf-8';

        request.body = body;
        await client
            .send(request)
            .then(
              (response) => response.stream.bytesToString().then(
                (value) {
                  print(value.toString());

                  deliverToUi(mapJsonToChatResponseModel(json.decode(value)));
                },
              ),
            )
            .catchError((error) => print(error.toString()));
      } catch (e) {
        print("@@@error decoding:$e");
      }
    }
  }

  ChatReponseModel mapJsonToChatResponseModel(Map json) {
    print("@@@@ ---- decoded $json");
    ChatReponseModel response = ChatReponseModel.fromJson(json);
    return response;
  }

  emitNewMessage(ChatUiMessage message) {
    print("Emitting messages ${message.message}");
    _internalMessageStreamSink.add(message);
  }

  ChatMessage configureChatMessage(ChatReponseModel response) {
    QuickReplies replies;
    if (response.suggested != null) if (response.suggested.length > 0) {
      List<Reply> reps = [];
      for (int i = 0; i < response.suggested.length; i++) {
        reps.add(Reply(
            title: response.suggested[i],
            value: response.suggested[i],
            messageId: "$i"));
      }
      replies = QuickReplies(keepIt: true, values: reps);
    }
    return ChatMessage(
        text: response.messages.last.message,
        user: _botUser,
        quickReplies: replies ?? QuickReplies());
  }

  void deliverToUi(ChatReponseModel response) {
    int messagesInResponse = response.messages.length;
    print("messages in response $messagesInResponse");

    int CardsInResponse = response.cards.length;

    ///First issue the text based messages to the stream
    ///Iterates over the messages and emits them one at a time
    for (int i = 0; i < messagesInResponse; i++) {
      if (i == messagesInResponse - 1) {
        emitNewMessage(
            new ChatUiMessage(message: configureChatMessage(response)));
      } else {
        emitNewMessage(new ChatUiMessage(
            message: ChatMessage(
                text: response.messages[i].message, user: _botUser, id: "$i")));
      }
    }
  }

  ///must call when done to prevent memory leaks
  dispose() {
    _apiStreamController.close();
    _internalMessageStreamSink.close();

    ///close the connection to the http client chatbot api
    client.close();
  }
}

class ChatUiMessage {
  final ChatMessage message;

  ///The delay in milliseconds to wait before showing the message
  ///To give the 'bot is typing' effect
  final int delayMilliSeconds;

  ChatUiMessage({@required this.message, this.delayMilliSeconds: 300});
}