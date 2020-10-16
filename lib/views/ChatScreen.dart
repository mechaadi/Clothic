import 'dart:async';

import 'package:clothic/api/chat_api.dart';
import 'package:clothic/model/chat.dart';
import 'package:clothic/model/user.dart';

import 'package:clothic/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  final String remoteUser;
  _ChatScreenState createState() => _ChatScreenState();
  ChatScreen({Key key, @required this.remoteUser}) : super(key: key);
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _controller = ScrollController();
  TextEditingController chatController = TextEditingController();

  String uid = auth.FirebaseAuth.instance.currentUser.uid;

  User remote;

  void getRemoteUser() async {
    remote = await UserServices.getUserById(widget.remoteUser);
    setState(() {});
    print(remote.name);
  }

  @override
  void initState() {
    getRemoteUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(uid + "asdasdasdsad" + remote.id);

    final userProvider = Provider.of<User>(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: Row(
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Padding(
                        child: Text(
                          remote.name,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        padding: EdgeInsets.only(left: 20),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(bottom: 10, left: 12, right: 12),
                ),
                Expanded(
                    child: Container(
                  child: ListView(
                    controller: _controller,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('chats')
                            .doc(uid)
                            .collection('users')
                            .doc(remote.id)
                            .collection('messages')
                            .orderBy("time", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          snapshot.data.docs.forEach((element) {
                            print(element);
                          });
                          if (snapshot.hasData) {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: snapshot.data.docs
                                    .map((doc) => doc.data()['user'] ==
                                            remote.id
                                        ? Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: Image.network(
                                                          remote.profilePic,
                                                          height: 40.0,
                                                          width: 40.0,
                                                        ),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          right: 8),
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 12,
                                                                horizontal: 16),
                                                        decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                        child: Row(
                                                          children: [
                                                            Text(doc.data()[
                                                                'message']),
                                                          ],
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 4),
                                          )
                                        : Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 12,
                                                                horizontal: 16),
                                                        decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                        child: Row(
                                                          children: [
                                                            Text(doc.data()[
                                                                'message']),
                                                          ],
                                                        )),
                                                    Container(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: Image.network(
                                                          userProvider
                                                              .profilePic,
                                                          height: 40.0,
                                                          width: 40.0,
                                                        ),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          left: 8),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 4),
                                          ))
                                    .toList());
                          } else {
                            return SizedBox(
                              child: Text(("LOADINGGG")),
                            );
                          }
                        },
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 12, right: 12),
                )),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black87,
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          child: TextField(
                            controller: chatController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Write something... ",
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.black,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          padding: EdgeInsets.only(
                              right: 10, left: 10, top: 5, bottom: 5),
                        )),
                        Padding(
                          child: InkWell(
                              child: Icon(Icons.send),
                              onTap: () {
                                sendMessage(
                                    userProvider.id, remote.id, userProvider);
                              }),
                          padding: EdgeInsets.all(10),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        )
      ],
    ));
  }

  void sendMessage(String user, String remoteuser, User userjson) {
    String msg = chatController.text;
    chatController.text = "";

    FirebaseFirestore.instance
        .collection('chats')
        .doc(user)
        .collection('users')
        .doc(remoteuser)
        .set({
      'name': remote.name,
      'dp': remote.profilePic,
      'msg': msg,
      'time': FieldValue.serverTimestamp(),
    });

    FirebaseFirestore.instance
        .collection('chats')
        .doc(remoteuser)
        .collection('users')
        .doc(user)
        .set({
      'name': userjson.name,
      'dp': userjson.profilePic,
      'msg': msg,
      'time': FieldValue.serverTimestamp(),
    });

    FirebaseFirestore.instance
        .collection('chats')
        .doc(user)
        .collection('users')
        .doc(remoteuser)
        .collection('messages')
        .add({
      'time': FieldValue.serverTimestamp(),
      'message': msg,
      'user': user
    }).then((value) {
      FirebaseFirestore.instance
          .collection('chats')
          .doc(remoteuser)
          .collection('users')
          .doc(user)
          .collection('messages')
          .add({
        'time': FieldValue.serverTimestamp(),
        'message': msg,
        'user': user
      }).then((value) {
        Timer(Duration(milliseconds: 1000),
            () => _controller.jumpTo(_controller.position.maxScrollExtent));
        chatController.text = "";
      });
    });
  }
}
