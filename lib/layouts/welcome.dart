import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final Color _darkTxtClr = HexColor("#96878D");
  final Color _btnColor = HexColor("#96878D");
  var opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: (loginLayout()),
      ),
    );
  }

  late AssetImage welcomeImg;

  @override
  void initState() {
    super.initState();
    welcomeImg = AssetImage('assets/animated electrician.gif');
    changeOpacity();
  }

  @override
  void dispose() {
    super.dispose();
    welcomeImg.evict();
  }

  changeOpacity() {
    Future.delayed(Duration(milliseconds: 1500), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
        // changeOpacity();
      });
    });
  }
  //========================
  // all heroes are disabled because aniamting Gif at start of welcome screen
  //========================
  Widget loginLayout() {
    return Stack(
      children: [
        loginLayoutBackGroundImage(),
        Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   colors: [
            //     Colors.white70,
            //     HexColor("#96878D"),
            //   ],
            // ),
            // color: Colors.greenAccent,
            borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(
                    MediaQuery.of(context).size.width, 32)),
          ),
          height: MediaQuery.of(context).size.height/1.75,
          child: Container(

            margin: EdgeInsets.only(top: 75),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // color: Colors.white,
              //   gradient: LinearGradient(
              //     begin: Alignment.topRight,
              //     end: Alignment.bottomLeft,
              //     colors: [
              //       Colors.brown[100]!,
              //       Colors.white70,
              //     ],
              //   )
            ),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.25,
                      child: Lottie.asset('assets/house building.json', repeat: false),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 35),
                  height: 3,
                  child: Divider(
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 15,),
                AnimatedOpacity(
                  opacity: opacity,
                    duration: Duration(milliseconds: 500),
                    child: Text('عشان بيتك يبقى أحسن', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: _darkTxtClr),)),
                // Divider(
                //   height: 30,
                //   color: Colors.brown,
                // )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 75),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Hero(
                        tag: "box",
                        child: Container(
                          height: 1,
                          width: 1,
                        )),
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
                        heroTag: AppStrings.heroLogin,
                        backgroundColor: _btnColor,
                        splashColor: Colors.white,
                        label: Text(
                          AppStrings.loginString,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
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
                        splashColor: _btnColor,
                        backgroundColor: Colors.white,
                        label: Text(
                          AppStrings.registerString,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: _btnColor),
                        ),
                        onPressed:
                            // () {}
                            navigateToRegisterWithMail,
                      ),
                    ),
                  ]),
                )),
          ),
        ),
      ],
    );
  }

  Widget loginLayoutBackGroundImage() {
    return Hero(
      tag: "bg",
      child: Image.asset(
        "assets/abstract bg.jpg",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }

  void navigateToRegisterWithMail() {
    // Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterWithMailLayout()),
    );
  }

  void navigateToLoginPage() {
    // Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginLayout()),
    );
  }
}
