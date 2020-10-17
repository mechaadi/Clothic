import 'package:clothic/api/user_api.dart';
import 'package:clothic/common/clothic_button_outlined.dart';
import 'package:clothic/model/donation.dart';
import 'package:clothic/model/user.dart';
import 'package:clothic/providers/auth_provider.dart';
import 'package:clothic/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    final userProvider = Provider.of<User>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final itemProvider = Provider.of<List<Donation>>(context);
    return Scaffold(
        backgroundColor: Color(0xff1b1b1b),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 30),
          child: Column(children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    userProvider.profilePic,
                    height: 80.0,
                    width: 80.0,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                    child: Column(
                  children: [
                    Align(
                      child: Text(
                        userProvider.name,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    SizedBox(height: 10),
                    ClothicButtonOutlined(
                      height: 30,
                      fontSize: 14,
                      color: Colors.white70,
                      text: "Edit profile",
                      onClick: () {},
                    )
                  ],
                )),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 40),
            Align(
              child: Text(
                "Donations",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
              alignment: Alignment.topLeft,
            ),
            Container(
              height: h/1.9,
              child: Expanded(
                child: StreamBuilder<List<Donation>>(
                    initialData: [],
                    stream: UserApi.getPosts(),
                    builder: (context, snapshot) {
                      List<Donation> donations = snapshot.data;
                      if (snapshot.hasData)
                        return GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, mainAxisSpacing: 20),
                            itemCount: donations.length,
                            itemBuilder: (context, i) => Container(
                                  child: ItemWidget(
                                      image: itemProvider[i].image,
                                      name: itemProvider[i].name),
                                ));
                      return CircularProgressIndicator();
                    }),
              ),
            ),
            ClothicButtonOutlined(
              height: 40,
              fontSize: 24,
              color: Colors.red,
              text: 'Logout',
              onClick: () {
                authProvider.signOut();
              },
            )
          ]),
        )));
  }
}
