import 'package:flutter/material.dart';
import 'package:waiter_app/components/rounded_button.dart';
import 'package:waiter_app/components/input_field.dart';
import 'package:waiter_app/components/password_field.dart';
import 'package:waiter_app/components/stroked_title.dart';
import 'package:waiter_app/requests/login_api.dart';

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

  @override
  void dispose() {
    _usernameFilter.dispose();
    _passwordFilter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Expanded(
              child: StrokedTitle(text: "GUSTO bistro"),
            ),
            Expanded(
              child: _buildTextFields(),
            ),
          ],
        ),
      ]),
    );
  }

  Widget _buildTextFields() {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 75, 25, 0),
      child: Form(
        key: _key,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            Expanded(
              child: InputField(
                hintText: 'Username',
                controller: _usernameFilter,
              ),
            ),
            Expanded(
              child: PasswordField(
                hintText: 'Password',
                controller: _passwordFilter,
              ),
            ),
            Expanded(
              child: RoundedButton(
                  text: "Sign In",
                  press: () {
                    if (_key.currentState.validate()) {
                      _username = _usernameFilter.text;
                      _password = _passwordFilter.text;
                      _key.currentState.save();
                      loginAndGetMenu(_username, _password);
                    }
                  }),
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
