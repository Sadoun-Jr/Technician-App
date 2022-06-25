import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:technicians/layouts/register%20with%20mail.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:http/http.dart' as http;
import 'package:technicians/widgets/glass%20box.dart';
import '../utils/strings enum.dart';
import '../widgets/logo.dart';
import 'login.dart';

class SelectRegisterMethodLayout extends StatefulWidget {
  const SelectRegisterMethodLayout({Key? key}) : super(key: key);

  @override
  State<SelectRegisterMethodLayout> createState() =>
      _SelectRegisterMethodLayoutState();
}

const String noAccountRegisterPlease = "Don't have an account?";
Color _primaryColor = HexColor("#1D4EAB");
Color _whiteText = Colors.white;
Color _midWhite = Colors.white54;

class _SelectRegisterMethodLayoutState
    extends State<SelectRegisterMethodLayout> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: (loginLayout()),
      ),
    );
  }

  Widget loginLayout() {
    return Stack(
      children: [
        loginLayoutBackGroundImage(),
        Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [

                Hero(
                  tag: "lottie",
                  child: Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 2, color: Colors.brown),
                    // ),
                    margin: EdgeInsets.fromLTRB(50,50,50,50),
                      child:
                          Lottie.asset(
                              'assets/29410-technical-assistance.json'),
                      height: 300,
                      width: 300,
                  ),
                ),
              ],
            )),
        Align(
          child: glassyLoginBox(),
          alignment: Alignment.bottomCenter,
        ),
        // loginBoxContents(),
      ],
    );
  }

  Widget loginLayoutBackGroundImage() {
    return Hero(
      tag: "bg",
      child: Image.asset(
        "assets/cyan_bg.jpg",
        fit: BoxFit.fitHeight,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }

  Widget glassyLoginBox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 75),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child:
          Align(alignment: Alignment.bottomCenter, child: loginBoxContents()),
    );
  }

  Widget loginBoxContents() {
    return SingleChildScrollView(
      child: Column(children: [
        Hero(
          tag: "box",
            child: Container(height: 1, width: 1,)),
        Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 50,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child:
          FloatingActionButton.extended(
            heroTag: AppStrings.heroLogin,

            backgroundColor: HexColor("#1651db"),
            splashColor: Colors.white,
            label: Text(
              AppStrings.loginString,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onPressed:
                // () {}
            navigateToLoginPage,
          ),
        ),
        Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 50,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: FloatingActionButton.extended(
            heroTag: AppStrings.heroRegister,
            splashColor: HexColor("#1651db"),
            backgroundColor: Colors.white,
            label: Text(
              AppStrings.registerString,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: HexColor("#1651db")),
            ),
            onPressed:
                // () {}
            navigateToRegisterWithMail,
          ),
        ),
        // Container(
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     color: Colors.transparent,
        //     border: Border.all(color: Colors.transparent),
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   height: 50,
        //   margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        //   child: FloatingActionButton.extended(
        //     heroTag: AppStrings.heroConnectwithFb,
        //     backgroundColor: Colors.white,
        //     icon: Icon(
        //       Icons.facebook,
        //       color: Colors.blue,
        //       size: 30,
        //     ),
        //     label: Text(
        //       AppStrings.connectWithFb,
        //       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        //     ),
        //     onPressed: () {
        //       Navigator.push(
        //           context, MaterialPageRoute(builder: (context) => TestUI()));
        //       // signInWithFacebook();
        //     },
        //     // onPressed: navigateToResetPassLayout,
        //   ),
        // ),
      ]),
    );
  }

  void navigateToRegisterWithMail() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterWithMailLayout()),
    );
  }

  void navigateToLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginLayout()),
    );
  }
}
