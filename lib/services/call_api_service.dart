import 'dart:convert';
import 'dart:io';

import 'package:digamobile/models/app_state.dart';
import 'package:http/http.dart' as http;

class CallApi{

  CallApi(this.endPointUrl:'https://diga-api.herokuapp.com/api/');

  final endPointUrl;
  http.Client client;
  
  ///A reference to the global redux [AppState] store to retrieve username and other config values
  ///Cannot be null
  AppState store;

  getPatientDetail(email,
      {store,
      String url}) async {
    //set the store reference
    if (store != null) {
      if (this.store == null) this.store = store;
    }

    ///[AppState] cannot be null, if not, throws an error
    assert(store != null, "Store is null");



    if (email != null) {
      print("Output @@@ ${email}");

       

      try {
        var urlEP =
            '${url??endPointUrl}/profile?email=$email';

        var request = new http.Request('POST', Uri.parse(urlEP));
        var body = json.encode({
          'm': "hello logs - :)",
        });
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
      }finally{
        client
      }
    }
  }
}