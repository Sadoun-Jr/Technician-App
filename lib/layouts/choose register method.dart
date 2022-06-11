import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:adobe_xd/adobe_xd.dart';
import 'package:technicians/utils/glass%20box.dart';
import 'package:technicians/utils/hex%20colors.dart';

import 'login.dart';

class SelectRegisterMethodLayout extends StatefulWidget {
  const SelectRegisterMethodLayout({Key? key}) : super(key: key);

  @override
  State<SelectRegisterMethodLayout> createState() => _SelectRegisterMethodLayoutState();
}

const String LOGIN_SCREEN_HEADER = "Sign in portal";
const String FORGOT_PASSWORD = "Forgot password";
const String SCHOOL_NAME = "TEXAS SCHOOL";
const String REGISTER_WITH_FB = "CONNECT WITH FACEBOOK";
const String REGISTER = "REGISTER";
const String USERNAME = "User Name";
const String EMAIL = "Email";
const String PASSWORD = "Password";
const String LOGIN = "LOGIN";
const String noAccountRegisterPlease = "Don't have an account?";
Color _primaryColor = HexColor("#1D4EAB");
Color _whiteText = Colors.white;
Color _midWhite = Colors.white54;


class _SelectRegisterMethodLayoutState extends State<SelectRegisterMethodLayout> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: (loginLayout()),
      ),
    );
  }

  Widget loginLayout() {
    return Stack(
      children: [
        loginLayoutBackGroundImage(),
        Align(alignment: Alignment.topCenter,
            child: Column(children:[
              SizedBox(height: 150,),
        logo(), ],)
        ),
        Align(child:
        glassyLoginBox(),
          alignment: Alignment.bottomCenter,),
        // loginBoxContents(),
      ],
    );
  }

  Widget loginLayoutBackGroundImage() {
    return Image.asset(
      "assets/Login.png",
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget logo() {
    return Container(
      height: 100,
      width: double.infinity,
      child: Container(
          alignment: Alignment.center,
          width: 75,
          height: 75,
          decoration:
              BoxDecoration(color: Colors.transparent,
                  border: Border.all(color: Colors.white.withOpacity(0.2),
                      width: 5.0),
                  shape: BoxShape.circle
              ),
          child: Icon(Icons.timer, size: 75,)
      ),
    );
  }

  Widget glassyLoginBox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 100),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          ),
      child:
          Align(
            alignment: Alignment.bottomCenter,
            child :loginBoxContents()
          ),
    );
  }

  Widget loginBoxContents() {

    return SingleChildScrollView(
      child: Column(children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 50,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: FloatingActionButton.extended(
            backgroundColor: _midWhite,
            label: Text(
              LOGIN,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onPressed: navigateToLoginPage,
            // onPressed: signIn,
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 50,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: FloatingActionButton.extended(
            backgroundColor: _midWhite,
            label: Text(
              REGISTER,
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onPressed: () => {},
            // onPressed: signIn,
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 50,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.white,
            icon: Icon(Icons.facebook, color: Colors.blue,size: 30,),
            label: Text(
              REGISTER_WITH_FB,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            onPressed: () => {},
            // onPressed: navigateToResetPassLayout,
          ),
        ),
      ]),
    );
  }

  void navigateToLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginLayout()),
    );  }
}
