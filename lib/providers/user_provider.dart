import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clothic/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserServices {
  FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;

  // current user stream
  Stream<User> streamHero() {
    var id = auth.FirebaseAuth.instance.currentUser.uid;

    return _fireStoreDataBase
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snap) => User.fromJson(snap.data()));
  }
}
