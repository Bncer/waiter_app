import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grouped_list/grouped_list.dart';

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
    return '{name: $name, weight: $weight, price: $price, category: $category}';
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int initNumber;
  Future<MenuModel> futureMenu;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Color _iconColor = Colors.black;

  int _currentCount;

  @override
  void initState() {
    _currentCount = initNumber ?? 0;
    super.initState();
    futureMenu = fetchMenu(secureStorage);
  }

  void _increment() {
    setState(() {
      _currentCount++;
    });
  }

  void _decrement() {
    setState(() {
      if (_currentCount > 0) {
        _currentCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MenuModel>(
      future: futureMenu,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Text("We don't have the data");
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        print(snapshot.data.items);
        return GroupedListView<dynamic, String>(
          elements: snapshot.data.items,
          groupBy: (element) => element.category,
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) => item1.name.compareTo(item2.name),
          order: GroupedListOrder.ASC,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          itemBuilder: (c, element) {
            return Card(
              elevation: 5.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Text(element.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => _decrement()),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black),
                        ),
                        child: Text(_currentCount.toString()),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => _increment(),
                      ),
                      IconButton(
                          icon:
                              Icon(Icons.check, color: _iconColor, size: 35.0),
                          onPressed: () {
                            setState(() {
                              _iconColor = _iconColor == Colors.greenAccent
                                  ? Colors.black
                                  : Colors.greenAccent;
                            });
                          }),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
