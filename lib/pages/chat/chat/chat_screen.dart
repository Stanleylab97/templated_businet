import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/chat/chat_params.dart';
import 'package:news_app/config/utils.dart' as duration;

import 'chat.dart';

class ChatScreen extends StatefulWidget {
  final ChatParams chatParams;

  const ChatScreen({Key key, this.chatParams}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseFirestore _firebase;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebase = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        elevation: 0.0,
        leading: Container(
          margin: EdgeInsets.fromLTRB(5, 5, 1, 5),
          child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  CachedNetworkImageProvider(widget.chatParams.peer.imageUrl)),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.chatParams.peer.name,
                style: TextStyle(fontSize: 14, color: Colors.white)),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.chatParams.peer.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Text(
                    snapshot.data['status'] == "Online"
                        ? "En ligne"
                        : "${duration.Utils.getDurationFromTimestamp(snapshot.data['lastseen'])}",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  );
                } else {
                  return Text("");
                }
              },
            )
          ],
        ),
      ),
      body: Chat(chatParams: widget.chatParams),
    );
  }
}
