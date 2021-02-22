import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waiter_app/constants.dart';

class OrderMenu extends StatefulWidget {
  @override
  _OrderMenu createState() => _OrderMenu();
}

class _OrderMenu extends State<OrderMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.receipt),
                  text: 'Order',
                ),
                Tab(
                  icon: Icon(Icons.menu_book),
                  text: 'Menu',
                ),
              ],
            ),
            title: Text('Username'),
            centerTitle: true,
            automaticallyImplyLeading: true,
          ),
          body: TabBarView(
            children: [
              Order(),
              Menu(),
            ],
          ),
        ),
      ),
    );
  }
}

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Order'),
    );
  }
}

Future<MenuModel> fetchMenu(FlutterSecureStorage storage) async {
  String tokenKey = await storage.read(key: 'token');

  var response = await http.get(Uri.encodeFull(baseUrl + 'api/v1/dishes/'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Authorization': 'Token $tokenKey',
      });
  if (response.statusCode == 200) {
    List<dynamic> responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    return MenuModel.fromJson(responseBody);
  } else {
    throw Exception('Failed to load album');
  }
}

class MenuModel {
  List<MenuItem> items;

  MenuModel({this.items});

  factory MenuModel.fromJson(List<dynamic> json) {
    List<MenuItem> menu = json.map((i) => MenuItem.fromJson(i)).toList();
    return MenuModel(items: menu);
  }
}

class MenuItem {
  final String name;
  final int weight;
  final int price;
  final String category;

  MenuItem({this.name, this.weight, this.price, this.category});

  factory MenuItem.fromJson(Map<dynamic, dynamic> json) {
    return MenuItem(
      name: json['name'],
      weight: json['weight'],
      price: json['price'],
      category: json['category'],
    );
  }
  @override
  String toString() {
    return 'MenuItem: {name: $name, weight: $weight, price: $price, category: $category}';
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Future<MenuModel> futureMenu;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    futureMenu = fetchMenu(secureStorage);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MenuModel>(
      future: futureMenu,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator();
        }
        if (!snapshot.hasData) {
          return Text("We don't have the data");
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        print(snapshot.data.items);
        return ListView.builder(
            itemCount: snapshot.data.items.length,
            itemBuilder: (BuildContext context, int i) {
              String name = snapshot.data.items[i].name;
              int weight = snapshot.data.items[i].weight;
              int price = snapshot.data.items[i].price;
              String category = snapshot.data.items[i].category;
              return ListTile(
                leading: Text('$category'),
                title: Text(
                  name ?? 'default value',
                ),
              );
            });
      },
    );
  }
}
