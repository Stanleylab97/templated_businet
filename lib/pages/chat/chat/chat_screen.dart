import 'package:flutter/material.dart';
import 'package:news_app/models/chat/chat_params.dart';

import 'chat.dart';

class ChatScreen extends StatelessWidget {
  final ChatParams chatParams;

  const ChatScreen({Key key,  this.chatParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red[600],
          elevation: 0.0,
          title: Text(chatParams.peer.name)
      ),
      body: Chat(chatParams: chatParams),
    );
  }
}
