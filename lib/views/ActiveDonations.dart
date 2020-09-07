import 'dart:io';

import 'package:clothic/api/donation_api.dart';
import 'package:clothic/common/clothic_button.dart';
import 'package:clothic/common/clothic_input.dart';
import 'package:clothic/model/donation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ActiveDonations extends StatefulWidget {
  @override
  _ActiveDonationsState createState() => _ActiveDonationsState();
}

class _ActiveDonationsState extends State<ActiveDonations> {
  File imageFile;
  String selectedCategory = "Shirt";
  String name = "", address = "";
  int itemCategory = 0;
  String btnState = "ADD";
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1b1b1b),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'New Donation :)',
                          style: optionStyle,
                        ),
                      ),
                      SizedBox(height: 10),
                      ClothicInput(
                        hint: 'Item Name',
                        onChange: (v) {
                          setState(() {
                            name = v;
                          });
                        },
                        maxLines: 1,
                        isPassword: false,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xff2a2a2a),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            child: DropdownButton<String>(
                              underline: SizedBox(),
                              isExpanded: true,
                              value: selectedCategory,
                              items: <String>[
                                'Shirt',
                                'Shoe',
                                'Trouser',
                                'Jacket'
                              ].map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (cat) {
                                setState(() {
                                  selectedCategory = cat;
                                });
                              },
                            ),
                            padding: EdgeInsets.only(left: 8, right: 8),
                          )),
                      ClothicInput(
                        hint: 'Address',
                        onChange: (v) {
                          setState(() {
                            address = v;
                          });
                        },
                        maxLines: 10,
                        isPassword: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      imageFile != null
                          ? Stack(
                              children: [
                                Image.file(
                                  imageFile,
                                  height: 100,
                                  width: 100,
                                ),
                                Positioned(
                                    top: 0,
                                    right: 10,
                                    child: InkWell(
                                      child: Icon(Icons.close),
                                      onTap: () {
                                        setState(() {
                                          imageFile = null;
                                        });
                                      },
                                    ))
                              ],
                            )
                          : InkWell(
                              child: Icon(
                                Icons.camera,
                                size: 40,
                              ),
                              onTap: () async {
                                var res = await ImagePicker.pickImage(
                                    source: ImageSource.camera);
                                setState(() {
                                  imageFile = res;
                                });
                              },
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      ClothicButton(
                        text: btnState,
                        onClick: () async {
                          setState(() {
                            btnState = "Please wait...";
                          });
                          if (name != "" && address != "") {
                            int item = 0;
                            if (selectedCategory == "Shirt") {
                              item = 0;
                            } else if (selectedCategory == "Trouser") {
                              item = 1;
                            } else if (selectedCategory == "Shoe") {
                              item = 2;
                            } else
                              item = 3;
                            String url =
                                await DonationAPI.storeImage(imageFile);
                            var res = await DonationAPI.addDonationItem(
                                Donation.named(
                                    name: name,
                                    address: address,
                                    image: url,
                                    cloth_type: item));
                            if(res != null){

                            }else{
                              setState(() {
                                btnState = "DONE!";
                              });
                            }
                          } else {
                            btnState = "ADD";
                            setState(() {});
                            print("NOO");
                          }
                        },
                        color: Colors.red,
                      )
                    ]))));
  }
}
