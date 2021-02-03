import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  String _username = "";
  String _password = "";

  _LoginPageState() {
    _usernameFilter.addListener(_usernameListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _usernameListen() {
    if (_usernameFilter.text.isEmpty) {
      _username = "";
    } else {
      _username = _usernameFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
              ),
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              _buildTitle(),
              _buildTextFields(),
              _buildButton(),
            ],
          ),
        ),
      ]),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Container(
        child: Center(
          child: 
          Stack(
            children: <Widget>[
              // Stroked text as border.
              Text(
                "KYZYL-KORGON",
                style: TextStyle(
                  fontSize: 26,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4
                    ..color = Colors.white,
                  fontFamily: 'Montserrat', fontWeight: FontWeight.bold,
                  letterSpacing: 6,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0.0, 6.0),
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                    ),
                  ]
                ),
              ),
              // Solid text as fill.
              Text(
                "KYZYL-KORGON",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(244, 40, 40, 1), 
                  fontSize: 26, letterSpacing: 6,
                ),
              ),
            ],
          )
        ),
      ),
      flex: 3,
    );
  }

  Widget _buildTextFields() {
    return Expanded(
      child: Container(
        child:  Column(
          children: <Widget>[
            Container(
              child:  TextField(
                controller: _usernameFilter,
                decoration:  InputDecoration(
                  labelText: 'Username'
                ),
              ),
            ),
            Container(
              child:  TextField(
                controller: _passwordFilter,
                decoration:  InputDecoration(
                  labelText: 'Password'
                ),
                obscureText: true,
              ),
            )
          ],
        ),
        // padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
      ),
      flex: 2,  
    );
  }

  Widget _buildButton() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
        child: RaisedButton(
          child: Text("Sign In"), 
          onPressed: _loginPressed,
        ),
      ),
      flex: 1,
    );
  }

  void _loginPressed () {
    print('The user wants to login with $_username and $_password');
  }
}
