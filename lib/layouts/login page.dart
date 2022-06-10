import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:adobe_xd/adobe_xd.dart';

class LoginLayout extends StatefulWidget {
  const LoginLayout({Key? key}) : super(key: key);

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: (loginScreenBackgroundImg()),
      ),
    );
  }

  Widget loginScreenBackgroundImg() {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        "assets/images/Login.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
