import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:adobe_xd/adobe_xd.dart';
import 'package:technicians/layouts/register%20with%20mail.dart';
import 'package:technicians/utils/hex%20colors.dart';

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
                SizedBox(
                  height: 150,
                ),
                Logo(75, 75),
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
    return Image.asset(
      "assets/Login.png",
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget glassyLoginBox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 100),
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
            heroTag: AppStrings.heroLogin,
            backgroundColor: _midWhite,
            label: Text(
              AppStrings.loginString,
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
            heroTag: AppStrings.heroRegister,
            backgroundColor: _midWhite,
            label: Text(
              AppStrings.registerString,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onPressed: navigateToRegisterWithMail,
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
            heroTag: AppStrings.heroConnectwithFb,
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.facebook,
              color: Colors.blue,
              size: 30,
            ),
            label: Text(
              AppStrings.connectWithFb,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            onPressed: () => {},
            // onPressed: navigateToResetPassLayout,
          ),
        ),
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
