import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';

import 'package:waiter_app/components/person.dart';
import 'package:waiter_app/constants.dart';

void loginAndGetMenu(String _username, String _password) async {
  Person user = Person(_username, _password);

  await FlutterSession().set("user", user);

  dynamic userCredentials = await FlutterSession().get("user");

  print(userCredentials);

  String basicAuth =
      'Basic ' + base64.encode(utf8.encode('$_username:$_password'));

  final http.Response response = await http.get(
    Uri.encodeFull(baseUrl),
    headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': basicAuth,
    },
  );
  List<dynamic> responseJson = json.decode(utf8.decode(response.bodyBytes));
  print(responseJson[1]["name"]);

  // final Map<String, dynamic> responseBody = json.decode(response.body);
  // final List<dynamic> personDynamic = responseBody['photos'];
  // final List<Person> person = personDynamic.map<Person>((dynamic p) {
  //   final Person person = Person();
  //   person.username = p['username'];
  //   person.username = p['username'];
  //   return person;
  // }).toList();
}
