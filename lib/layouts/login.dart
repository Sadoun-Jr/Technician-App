import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:adobe_xd/adobe_xd.dart';
import 'package:technicians/layouts/choose%20register%20method.dart';
import 'package:technicians/utils/glass%20box.dart';
import 'package:technicians/utils/hex%20colors.dart';

class LoginLayout extends StatefulWidget {
  const LoginLayout({Key? key}) : super(key: key);

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

const String LOGIN_SCREEN_HEADER = "Sign in portal";
const String FORGOT_PASSWORD = "Forgot password";
const String SCHOOL_NAME = "TEXAS SCHOOL";
const String REGISTER = "REGISTER";
const String USERNAME = "User Name";
const String EMAIL = "Email";
const String PASSWORD = "Password";
const String LOGIN = "LOGIN";
const String noAccountRegisterPlease = "Don't have an account?";
Color _primaryColor = HexColor("#1D4EAB");
Color _whiteText = Colors.white;
Color _midWhite = Colors.white54;


class _LoginLayoutState extends State<LoginLayout> {
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
        logo(),
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
      height: 150,
      width: double.infinity,
      child: Container(
          margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
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
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          ),
      child: FrostedGlassBox(
          470,
          Center(
            child :loginBoxContents()
          ),
          double.infinity),
    );
  }

  Widget loginBoxContents() {
    TextEditingController emailController = TextEditingController(
    );
    TextEditingController passwordController = TextEditingController();

    return SingleChildScrollView(
      child: Column(children: [
        // Container(
        //   alignment: Alignment.center,
        //   margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        //   child: Text(
        //     LOGIN_SCREEN_HEADER,
        //     style: TextStyle(
        //         fontSize: 24,
        //         color: _midWhite,
        //         fontWeight: FontWeight.bold),
        //   ),
        // ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextFormField(
            controller: emailController,
            maxLines: 1,
            style: TextStyle(color: _whiteText),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: _midWhite,
                  width: 1.25,
                ),
              ),
              prefixIcon: Icon(Icons.email,color: _midWhite,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: EMAIL,
              labelStyle: TextStyle(color: _whiteText),
              focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(color: _midWhite, width: 2.5),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: passwordController,
            maxLines: 1,
            style: TextStyle(color: _whiteText),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: _midWhite,
                  width: 1.25,
                ),
              ),
              prefixIcon: Icon(Icons.lock,color: _midWhite,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: PASSWORD,
              labelStyle: TextStyle(color: _whiteText),
              focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(color: _midWhite, width: 2.5),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
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
              LOGIN,
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
            label: Text(
              REGISTER,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            onPressed: navigateToRegisterPage,
            // onPressed: navigateToResetPassLayout,
          ),
        ),
        TextButton(
          child: Text(FORGOT_PASSWORD,),
          onPressed: () => {},
        )
      ]),
    );
  }

  void navigateToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectRegisterMethodLayout()),
    );
  }
}
