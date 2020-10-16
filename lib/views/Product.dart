import 'package:clothic/api/donation_api.dart';
import 'package:clothic/common/clothic_button.dart';
import 'package:clothic/model/donation.dart';
import 'package:clothic/views/ChatScreen.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String id;
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
  ProductDetails({Key key, @required this.id}) : super(key: key);
}

class _ProductDetailsState extends State<ProductDetails> {
  Donation donation = Donation.named(name: '', image: '', address: '');

  void loadProduc() async {
    donation = await DonationAPI.getDonationByID(widget.id);
    setState(() {});
  }

  @override
  void initState() {
    loadProduc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        donation.name,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.only(left: 20),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Image.network(
                  donation.image,
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: ClothicButton(
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                 
                          return ChatScreen(
                            remoteUser: donation.user,
                          );
                        }));
                      },
                      text: 'CHAT',
                      color: Colors.indigo,
                    )),
                    SizedBox(width: 20),
                    Expanded(
                        child: ClothicButton(
                      onClick: () {},
                      text: 'PICKUP',
                      color: Colors.indigo,
                    ))
                  ],
                ),
                SizedBox(height: 16),
                Row(children: [
                  Text(
                    donation.address,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.right,
                  )
                ]),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                        child: ClothicButton(
                      onClick: () {},
                      text: 'VIEW LOCATION',
                      color: Colors.blueGrey,
                    ))
                  ],
                ),
                SizedBox(height: 20),
                Row(children: [
                  Container(
                      child: Flexible(
                          child: Text(
                    "Other details, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    style: TextStyle(fontWeight: FontWeight.w300),
                    textAlign: TextAlign.left,
                  )))
                ]),
              ]),
              padding: EdgeInsets.only(top: 40, left: 20, right: 20),
            ),
          ],
        ),
      ),
    );
  }
}
