import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  final double fontSize;
  const AppName({Key key, @required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'B', //first part
        style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: Color.fromRGBO(233, 81, 59, 1)),
        children: <TextSpan>[
          TextSpan(
              text: 'usinet', //second part
              style: TextStyle(fontFamily: 'Poppins', color: Colors.grey[800])),
        ],
      ),
    );
  }
}
