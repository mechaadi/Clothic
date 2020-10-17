import 'package:clothic/model/user.dart';
import 'package:clothic/views/ChatScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RecentMessages extends StatefulWidget {
  @override
  _RecentMessagesState createState() => _RecentMessagesState();
}

class _RecentMessagesState extends State<RecentMessages> {
  String uid = auth.FirebaseAuth.instance.currentUser.uid;

  static const TextStyle optionStyle = TextStyle(
      fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white70);
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Color(0xff1b1b1b),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Container(
              child: Text(
                'Chats',
                style: optionStyle,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('chats')
                          .doc(userProvider.id)
                          .collection('users')
                          .snapshots(),
                      builder: (context, snapshot) {
                       
                        if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data.docs
                                .map((doc) => InkWell(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                  doc.data()['dp'],
                                                  height: 60,
                                                  width: 60,
                                                )),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  child: Text(
                                                    doc.data()['name'],
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      left: 8, top: 4),
                                                ),
                                                Padding(
                                                  child: Text(
                                                    timeAgoSinceDate(doc
                                                        .data()['time']
                                                        .toDate()
                                                        .toString()),
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      left: 8, top: 4),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatScreen(
                                                      remoteUser: doc.id)));
                                      },
                                    ))
                                .toList(),
                          );
                        } else {
                          return SizedBox(
                            child: Text(("LOADINGGG")),
                          );
                        }
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    DateTime notificationDate =
        DateFormat("yyyy-MM-dd hh:mm:ss.z").parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
