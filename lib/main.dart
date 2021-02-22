import 'package:flutter/material.dart';
import 'package:waiter_app/pages/home_page.dart';
import 'package:waiter_app/pages/login_page.dart';
import 'package:waiter_app/pages/order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waiter App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/order': (conext) => OrderMenu(),
      },
    );
  }
}
