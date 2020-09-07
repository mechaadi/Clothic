import 'package:clothic/model/donation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonationService {
  FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;

  // donation provider
  Stream<List<Donation>> streamDonations() {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var ref = _fireStoreDataBase
        .collection('donations')
        .where('user', isEqualTo: uid);
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => Donation.fromJson(doc.data())).toList());
  }
}
