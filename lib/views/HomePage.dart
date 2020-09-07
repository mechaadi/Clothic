import 'package:clothic/model/donation.dart';
import 'package:clothic/model/user.dart';
import 'package:clothic/providers/user_provider.dart';
import 'package:clothic/widgets/item_list.dart';
import 'package:clothic/widgets/item_widget.dart';
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
      backgroundColor: Color(0xff1b1b1b),
      body: SingleChildScrollView(
          child: Padding(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
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
                userProvider.name != null
                    ? Text(
                        "Hello, " + userProvider.name,
                        style: optionStyle,
                      )
                    : Container(),
              ],
            )),
            ItemList(
              category: 0,
              categoryName: "Shirts",
            ),
            ItemList(
              category: 1,
              categoryName: "Trousers",
            ),
            ItemList(
              category: 2,
              categoryName: "Shoes",
            ),
            ItemList(
              category: 3,
              categoryName: "Jackets",
            ),
          ],
        ),
        padding: EdgeInsets.only(left: 8, right: 8),
      )),
    );
  }
}
