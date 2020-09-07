import 'package:clothic/model/user.dart';
import 'package:clothic/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context);
    return Scaffold(
      body: Container(
          child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.network(
              userProvider.profilePic,
              height: 50.0,
              width: 50.0,
            ),
          ),
          SizedBox(width: 10),
          Text(
            "Hello, " + userProvider.name,
            style: optionStyle,
          ),
        ],
      )),
    );
  }
}
