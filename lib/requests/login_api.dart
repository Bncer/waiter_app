import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:waiter_app/constants.dart';

void loginAndGetMenu(String _username, String _password) async {
  // final storage = FlutterSecureStorage();

  String basicAuth =
      'Basic ' + base64.encode(utf8.encode('$_username:$_password'));

  // await storage.write(key: _username, value: basicAuth);

  // try {
  //   Map<String, String> allValues = await storage.readAll();
  //   print(allValues["admin"]);
  // } on Exception catch (_) {
  //   print('never reached');
  // }

  final http.Response response = await http.get(
    Uri.encodeFull(baseUrl),
    headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': basicAuth,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> responseJson = json.decode(utf8.decode(response.bodyBytes));
    print(responseJson);
  } else {
    throw Exception('Failed to load data.');
  }
}
