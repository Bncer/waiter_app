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
  final GlobalKey<FormState> _key = GlobalKey();

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
        Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: _buildTitle(),
              ),
              Expanded(
                child: _buildTextFields(),
              ),
            ],
          ),
      ]),
    );
  }

  Widget _buildTitle() {
    return Container(
      child: Center(
        child: Stack(
          children: <Widget>[
            // Stroked text as border.
            Text(
              "GUSTO bistro",
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
              "GUSTO bistro",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold,
                color: Color.fromRGBO(244, 40, 40, 1), 
                fontSize: 26, letterSpacing: 6,
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget _buildTextFields() {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 75, 25, 0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  controller: _usernameFilter,
                  decoration:  InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                    ),
                    enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.white),   
                    ),  
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            child: Container(
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                controller: _passwordFilter,
                decoration:  InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                  ),
                  enabledBorder: UnderlineInputBorder(      
                    borderSide: BorderSide(color: Colors.white),   
                  ),  
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
                obscureText: true,
              ),
              // padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
            ),
          ),
          Expanded(
            child: _buildButton(),
            flex: 3,
          ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 60.0,
            // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: RaisedButton(
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                ),
              ),
              onPressed: _loginPressed,
              elevation: 5.0,
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17.0),
                side: BorderSide(color: Colors.red)
              ),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.only(top:30)
    );
  }

  void _loginPressed () {
    print('The user wants to login with $_username and $_password');
  }
}
