import 'package:flutter/material.dart';
import 'package:news_app/models/chat/chat_params.dart';
import 'package:news_app/models/chat/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/config/utils.dart' as duration;

class ChatRoom extends StatefulWidget {
  // final AuthenticationService _auth = AuthenticationService();

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    if (status == "Offline")
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({"status": status, "lastseen": FieldValue.serverTimestamp()});
    else
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        "status": status,
      });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  @override
  Widget build(BuildContext context) {
    //  NotificationService.initialize();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        elevation: 2,
        title: Text(
          'Liste de discussions',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  SizedBox(width: 10),
                  Icon(Icons.search),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text("Rechercher une conversation"),
                    ),
                  ),
                  Icon(Icons.more_vert_outlined),
                  SizedBox(width: 10),
                ])),
            Expanded(child: UserList())
          ],
        ),
      ),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    // final users = FirebaseFirestore.instance.collection('users').snapshots();
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser.uid)
            .where('category', isEqualTo: "Entrepreneur")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Veuillez réessayer plus tard.'));
          }
          // final x = snapshot.data.docs.length;
          // print("Record lenght: $x");
          //
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data.docs[index];
                return UserTile(AppUserData(
                    name: doc['name'],
                    uid: doc['uid'],
                    imageUrl: doc['image url'],
                    status: doc['status'] == "Online"
                        ? "En Ligne"
                        : "${duration.Utils.getDurationFromTimestamp(doc['lastseen'])}"));
              });
        });
  }
}

class UserTile extends StatelessWidget {
  final AppUserData user;

  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final currentUser = AppUser(FirebaseAuth.instance.currentUser.uid);
    if (currentUser == null) throw Exception("current user not found");
    return GestureDetector(
        onTap: () {
          if (currentUser.uid == user.uid) return;
          Navigator.pushNamed(
            context,
            '/chat',
            arguments: ChatParams(currentUser.uid, user),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: Card(
            margin:
                EdgeInsets.only(top: 1.0, bottom: 1.0, left: 5.0, right: 5.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: ListTile(
                leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: CachedNetworkImageProvider(user.imageUrl)),
                title: Text(user.name),
                subtitle: Text('${user.status}'),
              ),
            ),
          ),
        ));
  }
}
