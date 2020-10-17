import 'package:clothic/api/donation_api.dart';
import 'package:clothic/common/clothic_button.dart';
import 'package:clothic/model/donation.dart';
import 'package:clothic/views/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    // SizedBox(width: 20),
                    // Expanded(
                    //     child: ClothicButton(
                    //   onClick: () {},
                    //   text: 'PICKUP',
                    //   color: Colors.indigo,
                    // ))
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
                      onClick: () async {
                        String googleUrl =
                            'https://www.google.com/maps?q=${donation.address}';
                        if (await canLaunch(googleUrl)) {
                          await launch(googleUrl);
                        } else {
                          throw 'Could not open the map.';
                        }
                      },
                      text: 'VIEW LOCATION',
                      color: Colors.blueGrey,
                    ))
                  ],
                ),
                SizedBox(height: 20),
              ]),
              padding: EdgeInsets.only(top: 40, left: 20, right: 20),
            ),
          ],
        ),
      ),
    );
  }
}
