import 'package:clothic/model/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clothic/model/user.dart' as user;

class ChatAPI{

    static Stream<List<Chat>> getMessages(String remoteUser) async* {
    print("00000000000000000000000000000000000000");
    String uid = FirebaseAuth.instance.currentUser.uid;
    print(uid);
    List<Chat> chatList = [];

    // Get chats
    await for (QuerySnapshot snapshot
        in FirebaseFirestore.instance.collection('chats').doc('QsRWVWjgXvaQViM2zj2IZtzcBvp2').collection('rGJ3F7dExHdfywYLwO0aThQhVZJ3').snapshots()) {
        print(snapshot.docs);
      snapshot.docs.forEach((element) {
          print(element);
          chatList.add(Chat.fromJson(element.data()));
        
      });
      yield chatList;
    }
  }

  static Stream<List<Chat>> getAllMessages(String remoteUser){
    FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;
    
    var ref = _fireStoreDataBase.collection('chats').doc('QsRWVWjgXvaQViM2zj2IZtzcBvp2').collection('rGJ3F7dExHdfywYLwO0aThQhVZJ3');
    ref.snapshots().forEach((element) {print(element);});
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => Chat.fromJson(doc.data())).toList());
  }

}