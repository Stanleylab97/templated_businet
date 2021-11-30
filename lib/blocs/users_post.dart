import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/post.dart';

class UsersPostsBloc extends ChangeNotifier {
  List<Post> _data = [];
  List<Post> get data => _data;

 

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getData() async {
    QuerySnapshot rawData;
    rawData = await firestore
        .collection('posts')
        .orderBy('publishedAt', descending: true)
        .get();

    List<DocumentSnapshot> _snap = [];
    _snap.addAll(rawData.docs);
   // _data = _snap.map((e) => Post.fromFirestore(e)).toList();
    notifyListeners();
  }

  onRefresh() {
    _data.clear();
    getData();
    notifyListeners();
  }
}
