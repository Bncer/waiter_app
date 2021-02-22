import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _createOrder() {
    Navigator.pushReplacementNamed(context, '/order');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Username'),
        centerTitle: true,
      ),
      body: ListView(
        children: [ListTile(leading: Container(child: Text('Room #1')))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createOrder,
        tooltip: 'Create',
        child: new Icon(Icons.add),
      ),
    );
  }
}
