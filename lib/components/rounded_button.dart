import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;

  const RoundedButton({Key key, this.text, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 60.0,
              child: RaisedButton(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),
                onPressed: press,
                elevation: 5.0,
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.0),
                    side: BorderSide(color: Colors.red)),
              ),
            ),
          ],
        ),
        padding: EdgeInsets.only(top: 30));
  }
}
