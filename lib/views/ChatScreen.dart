import 'dart:async';
import 'package:clothic/model/user.dart';

import 'package:clothic/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
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

  User remote = null;

  void getRemoteUser() async {
    remote = await UserServices.getUserById(widget.remoteUser);
    setState(() {});
  }

  @override
  void initState() {
    getRemoteUser();
    Timer(Duration(milliseconds: 10),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;

    final userProvider = Provider.of<User>(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Material(
                  elevation: 4,
                  color: Color(0xff202020),
                  child: Padding(
                    child: Row(
                      children: [
                        ClipOval(
                          child: Material(
                            color: Color(0xff202020),
                            child: InkWell(
                              child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Icon(Icons.arrow_back_ios)),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        remote != null
                            ? Padding(
                                child: ClipRRect(
                                  child: Image.network(remote.profilePic,
                                      height: 40, width: 40),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: EdgeInsets.only(left: 2),
                              )
                            : Container(),
                        remote != null
                            ? Padding(
                                child: Text(
                                  remote.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                padding: EdgeInsets.only(left: 4),
                              )
                            : Container(),
                      ],
                    ),
                    padding: EdgeInsets.only(
                        bottom: 8, top: 40, left: 12, right: 12),
                  ),
                ),
                remote != null
                    ? Expanded(
                        child: Container(
                        child: ListView(
                          controller: _controller,
                          children: [
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('chats')
                                  .doc(userProvider.id)
                                  .collection('users')
                                  .doc(remote.id)
                                  .collection('messages')
                                  .orderBy("time", descending: false)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Timer(
                                      Duration(milliseconds: 10),
                                      () => _controller.jumpTo(_controller
                                          .position.maxScrollExtent));
                                  return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                                      .circular(
                                                                          50),
                                                              child:
                                                                  Image.network(
                                                                remote
                                                                    .profilePic,
                                                                height: 40.0,
                                                                width: 40.0,
                                                              ),
                                                            ),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 8),
                                                          ),
                                                          Container(
                                                            constraints: BoxConstraints(maxWidth: c_width),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          16),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white10,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              8))),
                                                              child: 
                                                                  Text(doc.data()[
                                                                      'message']),
                                                                ),
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
                                                            constraints: BoxConstraints(maxWidth: c_width),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        12,
                                                                    horizontal:
                                                                        16),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .black,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                            child: Text(
                                                                doc.data()[
                                                                    'message']),
                                                          ),
                                                          Container(
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              child:
                                                                  Image.network(
                                                                userProvider
                                                                    .profilePic,
                                                                height: 40.0,
                                                                width: 40.0,
                                                              ),
                                                            ),
                                                            margin:
                                                                EdgeInsets.only(
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
                                  return Expanded(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(left: 12, right: 12),
                      ))
                    : Expanded(
                        child: Container(),
                      ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xff202020),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          child: TextField(
                            onTap: () {
                              Timer(
                                  Duration(milliseconds: 300),
                                  () => _controller.jumpTo(
                                      _controller.position.maxScrollExtent));
                            },
                            controller: chatController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Write something... ",
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color(0xff202020),
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
        Timer(Duration(milliseconds: 10),
            () => _controller.jumpTo(_controller.position.maxScrollExtent));
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
      });
    });
  }
}
