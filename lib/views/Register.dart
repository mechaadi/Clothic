import 'package:clothic/api/user_api.dart';
import 'package:clothic/common/clothic_button.dart';
import 'package:clothic/common/clothic_input.dart';
import 'package:clothic/model/user.dart';
import 'package:clothic/providers/user_provider.dart';
import 'package:clothic/views/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String password = "", confirmPassword = "", name = "", email = "";
  String btnState = "REGISTER";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xff1b1b1b),
          body: Center(child:SingleChildScrollView(
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
                          "Register on",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Clothic",
                          style: TextStyle(
                              fontSize: 60, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ClothicInput(
                        hint: 'Name',
                        isPassword: false,
                        onChange: (v) {
                          setState(() {
                            name = v;
                          });
                        },
                        maxLines: 1,
                      ),
                      ClothicInput(
                        hint: 'Email',
                        isPassword: false,
                        onChange: (v) {
                          setState(() {
                            email = v;
                          });
                        },
                        maxLines: 1,
                      ),
                      ClothicInput(
                        hint: 'Password',
                        isPassword: true,
                        onChange: (v) {
                          setState(() {
                            password = v;
                          });
                        },
                        maxLines: 1,
                      ),
                      ClothicInput(
                        hint: 'Confirm Password',
                        isPassword: true,
                        onChange: (v) {
                          setState(() {
                            confirmPassword = v;
                          });
                        },
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ClothicButton(
                        onClick: () async {
                          handleRegister();
                        },
                        text: btnState,
                        color: Colors.redAccent,
                      ),
                      ClothicButton(
                        onClick: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                        },
                        text: 'LOGIN',
                        color: Colors.indigo,
                      )
                    ],
                  ))))),
        ),
        onWillPop: () async {
          return true;
        });
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

  void handleRegister() async {
    setState(() {
      btnState = "Please wait..";
    });
    if (password != confirmPassword) {
      btnState = "REGISTER";
      showSnackBar("Password doesn't match", Colors.red, Colors.white);
    }
    if (name != "" && email != "" && password != "") {
      User user =
          User.named(name: name, email: email, address: " ", userType: 0);

      var res = await UserApi.createUser(user, password);

      if (res != null) {
        btnState = "REGISTER";
        showSnackBar(res, Colors.red, Colors.white);
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
        setState(() {});
      }
    } else {
      btnState = "REGISTER";
      setState(() {});
      showSnackBar("All fields are mandatory", Colors.red, Colors.white);
    }
  }
}
