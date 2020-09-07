import 'package:clothic/common/clothic_button.dart';
import 'package:clothic/providers/auth_provider.dart';
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
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Container(
          child: ClothicButton(
        color: Colors.red,
        text: 'Logout',
        onClick: () {
          authProvider.signOut();
        },
      )),
    );
  }
}
