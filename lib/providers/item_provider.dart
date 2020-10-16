import 'package:clothic/model/donation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemServices {
  FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;

  // shirt provider
  Stream<List<Donation>> streamItems() {
    var ref = _fireStoreDataBase.collection('donations');
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => Donation.fromJson(doc.data())).toList());
  }
}
