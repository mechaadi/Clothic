import 'dart:io';
import 'dart:typed_data';

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:clothic/model/donation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class DonationAPI {
  static Future<Uint8List> compressImage(File file) async {
    try {
      File compressedFile = await FlutterNativeImage.compressImage(file.path,
          quality: 75, percentage: 50);
      print("Size ${compressedFile.statSync().size}");
      return compressedFile.readAsBytesSync();
    } catch (e) {
      print("Excpetion $e");
      return null;
    }
  }

  static Future<String> storeImage(File file, {bool compress = true}) async {
    try {
      Uint8List data;
      if (compress) {
        data = await compressImage(file);
      } else {
        data = file.readAsBytesSync();
      }
      StorageReference reference = FirebaseStorage.instance
          .ref()
          .child('itempics')
          .child(DateTime.now().toString());
      StorageUploadTask uploadTask = reference.putData(data);
      var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
      return dowurl;
    } catch (e) {
      return null;
    }
  }

  static Future<String> addDonationItem(Donation donation) async {
    var bytes = utf8.encode(DateTime.now().toString()); // data being hashed
    var digest = sha1.convert(bytes);
    String uid = FirebaseAuth.instance.currentUser.uid;
    donation.user = uid;
    donation.id = digest.toString();
    try {
      await FirebaseFirestore.instance
          .collection('donations')
          .doc(digest.toString())
          .set(donation.toJson());
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
