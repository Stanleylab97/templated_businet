import 'package:flutter/material.dart';
import 'package:news_app/models/chat/chat_params.dart';
import 'package:news_app/models/chat/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRoom extends StatelessWidget {
  // final AuthenticationService _auth = AuthenticationService();

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
      body: UserList(),
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

          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data.docs[index];
                return UserTile(
                    AppUserData(name: doc['name'], uid: doc['uid']));
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
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin:
              EdgeInsets.only(top: 12.0, bottom: 6.0, left: 20.0, right: 20.0),
          child: ListTile(
            title: Text(user.name),
            // subtitle: Text('Drink ${user.waterCounter} water of glass'),
          ),
        ),
      ),
    );
  }
}
