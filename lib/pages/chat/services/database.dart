import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/models/chat/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> saveUser(String name, int waterCounter) async {
    return await userCollection.doc(uid).set({'name': name, 'waterCount': waterCounter});
  }

  Future<void> saveToken(String token) async {
    return await userCollection.doc(uid).update({'token': token});
  }

  AppUserData _userFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return AppUserData(
      uid: snapshot.id,
      name: data['name'],
         );
  }

  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<AppUserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<AppUserData>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}
