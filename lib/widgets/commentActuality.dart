import 'package:flutter/material.dart';

class CommentActuality extends StatefulWidget {
  const CommentActuality({Key key}) : super(key: key);

  @override
  _CommentActualityState createState() => _CommentActualityState();
}

class _CommentActualityState extends State<CommentActuality> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Center(child: Text("Commenter"))),
    );
  }
}
