import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clothic/model/user.dart' as user;

class UserApi {
  static Future<String> login(email, password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.toString().trim(), password: password.toString().trim());
      return null;
    } catch (e) {
      if (e != null)
        return e.toString();
      else
        return null;
    }
  }

  static Future<String> createUser(user.User userData, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userData.email.toString().trim(),
          password: password.toString().trim());
      var res =  FirebaseAuth.instance.currentUser; 
      await FirebaseFirestore.instance
          .collection('users')
          .doc(res.uid)
          .set(userData.toJson());
      return null;
    } catch (e) {
      if (e != null) {
        return e.toString();
      } else {
        return null;
      }
    }
  }
}
