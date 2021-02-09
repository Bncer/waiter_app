import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  
  const PasswordField({
    Key key,
    this.controller,
    this.hintText,
    this.icon = Icons.lock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        controller: controller,
        decoration:  InputDecoration(
          hintText: hintText,
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
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        obscureText: true,
      ),
    );
  }
}