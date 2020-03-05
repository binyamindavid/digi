import 'dart:convert';
import 'dart:io';

import 'package:digamobile/actions/auth_actions.dart';
import 'package:digamobile/models/api_specific_models/diga_api_patient_model.dart';
import 'package:digamobile/models/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

class CallApi {
  CallApi(
      {this.endPointUrl: 'https://diga-api.herokuapp.com/api', this.store}) {
    if (client == null) client = http.Client();
  }

  final endPointUrl;
  http.Client client;

  ///A reference to the global redux [AppState] store to retrieve username and other config values
  ///Cannot be null
  Store<AppState> store;

  getPatientDetail(email, {store, String url}) async {
    //set the store reference
    if (store != null) {
      if (this.store == null) this.store = store;
    }

    ///[AppState] cannot be null, if not, throws an error
    assert(store != null, "Store is null");

    if (email != null) {
      print("Output @@@ ${email}");

      try {
        var urlEP = '${url ?? endPointUrl}/profile?email=$email';

        print("@@@ ----  $urlEP");

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

                  if (value == null) {
                    return;
                  }

                  ///create a new [DiagPatientModel] from the received api call
                  ///then transpose that client to to the store for use in subsequent interactions
                  DiagPatientModel client =
                      DiagPatientModel.fromJson(json.decode(value));

                  if (client != null) {
                    this
                        .store
                        .dispatch(SavePatientDataAction(patientData: client));
                  }

                  // deliverToUi(mapJsonToChatResponseModel(json.decode(value)));
                },
              ),
            )
            .catchError((error) => print(error.toString()));
      } catch (e) {
        print("@@@error decoding:$e");
      }
    }
  }

  postMessages(email, {store, String url}) async {
    ///[AppState] cannot be null, if not, throws an error
    assert(store != null, "Store is null");

    if (email != null) {
      print("Output @@@ ${email}");

      try {
        //iterate through the messages and concat them to the body text
        String bodyTxt = "";
        this.store.state.messages.forEach((element) {
          bodyTxt = "$bodyTxt" "$element";
        });

        var urlEP = '${url ?? endPointUrl}/new_messages?email=$email';

        print("@@@ ----  $bodyTxt");

        var request = new http.Request('POST', Uri.parse(urlEP));
        var body = json.encode({
          'id': "${this.store.state.patientData.id}",
          'body': '$bodyTxt',
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

                  if (value == null) {
                    return;
                  }
                },
              ),
            )
            .catchError((error) => print(error.toString()));
      } catch (e) {
        print("@@@error decoding:$e");
      }
    }

    ///Dispose and close connections
    void dispose() {
      if (client != null) client.close();
    }
  }
}
