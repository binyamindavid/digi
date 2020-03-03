import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:dash_chat/dash_chat.dart';

class ChatbotServiceConfig {
  ChatbotServiceConfig(this.endPointUrl) {
    if (client == null) client = http.Client();
  }

  ///Add the requured params for the conversation stream
  ///The [user_id] should be unique
  String userId = "Fjorde_${DateTime.now().millisecondsSinceEpoch}";

  ///[message_id] only used when continuing a chat from a different platform,
  ///default to 0
  int messageId = 0;
  //api endpoint url, should be passed into the build proccess on the final build
  //for now, will be hard coded.
  final endPointUrl;
  http.Client client;

  ///[StreamController] Controls the stream and Sink for message api
  ///Set to broadcast so the messages don't decay on first emmit
  StreamController _apiStreamController = StreamController.broadcast();

  ///[chatBotMessageStream] is a [Stream]that will be subscribed to by any listeners
  ///emmits messages from this api that are passed into the internal [StreamSink]
  Stream get chatBotMessageStream => _apiStreamController.stream;

  ///[_internalMessageStreamSink] is the internal  [StreamSink]
  ///that is used to pass data to all listeners
  StreamSink get _internalMessageStreamSink => _apiStreamController.sink;

  sendMessage(ChatMessage message,
      {String url:
          'https://account.snatchbot.me/channels/api/api/id94441/appcom.moozenhq.digamobile/apsF58DCEC4F87FBF5BFADE9F5D56F91'}) async {
    if (message.text != null) {
      print("Output @@@ ${message.text}");
      try {
        var urlEP =
            '${url}?user_id=${this.userId}&message_id=${this.messageId}';
        // var client = new http.Client();
        var request = new http.Request('POST', Uri.parse(urlEP));
        var body = json.encode({'message': message.text});
        request.headers[HttpHeaders.contentTypeHeader] =
            'application/json; charset=utf-8';

        request.body = body;
        await client
            .send(request)
            .then((response) => response.stream
                .bytesToString()
                .then((value) => print(value.toString())))
            .catchError((error) => print(error.toString()));
      } catch (e) {
        print("@@@error decoding:$e");
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
