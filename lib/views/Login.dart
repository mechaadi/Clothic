import 'package:clothic/api/user_api.dart';
import 'package:clothic/common/clothic_button.dart';
import 'package:clothic/common/clothic_input.dart';
import 'package:clothic/providers/user_provider.dart';
import 'package:clothic/views/Register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, password;
  @override
  Widget build(BuildContext context) {
    //final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xff1b1b1b),
      body: Center(
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(top: 50, left: 24, right: 24),
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Login to",
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Clothic",
                          style: TextStyle(fontSize: 60),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ClothicInput(
                        hint: 'Email',
                        isPassword: false,
                        onChange: (v) {
                          email = v;
                        },
                        maxLines: 1,
                      ),
                      ClothicInput(
                        hint: 'Password',
                        isPassword: true,
                        onChange: (v) {
                          password = v;
                        },
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ClothicButton(
                        text: 'LOGIN',
                        color: Colors.redAccent,
                        onClick: () async {
                          await UserApi.login(email, password);
                          //userProvider.setUser();
                          setState(() {});
                        },
                      ),
                      ClothicButton(
                        onClick: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                        },
                        text: 'CREATE ACCOUNT',
                        color: Colors.indigo,
                      )
                    ],
                  ))))),
    );
  }
}
