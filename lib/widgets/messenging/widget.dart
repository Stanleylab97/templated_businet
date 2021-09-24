import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset(
      "assets/icons/longLogo.png",
      height: 40,
    ),
    elevation: 0.0,
    centerTitle: false,
  );
}

Widget chatAppBar(BuildContext context, String username, String photo) {
  return AppBar(
    backgroundColor: Colors.grey[350],
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back_ios, color: Colors.black),
    ),
    title: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image:
                DecorationImage(image: NetworkImage(photo), fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(username,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            SizedBox(
              height: 3,
            ),
            Text("En ligne",
                style: TextStyle(fontSize: 13, color: Colors.black))
          ],
        )
      ],
    ),
    elevation: 0.0,
    centerTitle: false,
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}
