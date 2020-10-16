import 'package:clothic/views/Info.dart';
import 'package:clothic/views/RecentMessages.dart';
import 'package:flutter/material.dart';
import 'package:clothic/views/ActiveDonations.dart';
import 'package:clothic/views/HomePage.dart';
import 'package:clothic/views/Profile.dart';

class WrapperPage extends StatefulWidget {
  @override
  _WrapperPageState createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ActiveDonations(),
    RecentMessages(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1b1b1b),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            title: Text('New Donation'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Chats'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
      body: Padding(
        child: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      ),
    );
  }
}
