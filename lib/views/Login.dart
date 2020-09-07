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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String email = "", password = "";
  String btnState = "Login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Clothic",
                          style: TextStyle(
                              fontSize: 60, fontWeight: FontWeight.bold),
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
                        text: btnState,
                        color: Colors.redAccent,
                        onClick: () async {
                          setState(() {
                            btnState = "Please wait...";
                          });
                          if (email != "" && password != "") {
                            var res = await UserApi.login(email, password);
                            if (res != null) {
                              showSnackBar(res, Colors.red, Colors.white);
                              btnState = "LOGIN";
                              setState(() {});
                            }
                          } else {
                            btnState = "LOGIN";
                            setState(() {});
                            showSnackBar("Fields are required", Colors.red,
                                Colors.white);
                          }
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

  void showSnackBar(String msg, Color color, Color textColor) {
    final snackBarContent = SnackBar(
      backgroundColor: color,
      content: Text(
        msg,
        style: TextStyle(color: textColor),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBarContent);
  }
}
