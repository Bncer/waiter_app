import 'package:flutter/material.dart';

class StrokedTitle extends StatelessWidget {
  final String text;

  const StrokedTitle ({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          children: <Widget>[
            // Stroked text as border.
            Text(
              text,
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
              text,
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
}