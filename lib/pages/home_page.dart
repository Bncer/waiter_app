import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waiter_app/constants.dart';

Future fetchMenu(FlutterSecureStorage storage) async {
  String tokenKey = await storage.read(key: 'token');

  final response = await http.get(Uri.encodeFull(baseUrl + 'api/v1/dishes/'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Token $tokenKey',
      });
  print(response.body);
  if (response.statusCode == 200) {
    print(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load album');
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usernam'),
        // automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: ListView(
        children: [ListTile(leading: Container(child: Text('Room #1')))],
      ),
    );
  }
}
