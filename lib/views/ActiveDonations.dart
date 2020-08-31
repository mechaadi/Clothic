import 'package:flutter/material.dart';

class ActiveDonations extends StatefulWidget {
  @override
  _ActiveDonationsState createState() => _ActiveDonationsState();
}

class _ActiveDonationsState extends State<ActiveDonations> {
    static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Donations Page', style: optionStyle,),
      ),
    );
  }
}
