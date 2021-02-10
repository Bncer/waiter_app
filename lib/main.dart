import 'package:flutter/material.dart';
import 'package:waiter_app/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waiter App',
      home: LoginPage(),
    );
  }
}
