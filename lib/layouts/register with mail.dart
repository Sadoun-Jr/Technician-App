import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technicians/layouts/login.dart';
import 'package:technicians/layouts/set%20personal%20details.dart';
import 'package:technicians/main.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/widgets/glass%20box.dart';
import 'package:technicians/widgets/slider.dart';
import '../utils/strings enum.dart';
import '../widgets/logo.dart';

class RegisterWithMailLayout extends StatefulWidget {
  const RegisterWithMailLayout({Key? key}) : super(key: key);

  @override
  State<RegisterWithMailLayout> createState() => _RegisterWithMailLayoutState();
}

class _RegisterWithMailLayoutState extends State<RegisterWithMailLayout> {
  final Color _textColor = HexColor("#052163");
  final Color _borderColor = HexColor("#0d3fb5");
  final Color _primaryColor = HexColor("##1651db");

  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late var prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();

  }

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
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Lottie.asset(
                        'assets/29410-technical-assistance.json'),
                  ),
                ),
              ],
            )),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
          child: Align(
            child: glassyLoginBox(),
            alignment: Alignment.bottomCenter,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,

            height: 50,
            margin: const EdgeInsets.fromLTRB(50, 0, 50, 50),
            child: Visibility(
              visible:MediaQuery.of(context).viewInsets.bottom == 0,
              child: FloatingActionButton.extended(
                heroTag: AppStrings.heroRegister,
                backgroundColor: _borderColor,
                label: Text(
                  AppStrings.createAccountButton,
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                onPressed: () => {
                  signUp()
                },
                // onPressed: signIn,
              ),
            ),
          ),
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
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }

  Widget glassyLoginBox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Hero(
        tag: "box",
        child: Material(
          color: Colors.transparent,
          child: FrostedGlassBox(
            350,
            double.infinity,
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: loginBoxContents())),
          ),
        ),
      ),
    );
  }

  Widget loginBoxContents() {

    return SingleChildScrollView(
      child: Column(children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 15),
          child: Text(
            AppStrings.registerNewAccountString,
            style: TextStyle(
                fontSize: 24, color: _borderColor, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: formKey,
            child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
              email != null && !EmailValidator.validate(email)
                  ? "Enter a valid Email"
                  : null,
              maxLines: 1,
              style: TextStyle(color: _textColor),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: _borderColor,
                    width: 1.25,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: _borderColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: AppStrings.emailString,
                labelStyle: TextStyle(color: _textColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _borderColor, width: 2.5),
                  borderRadius: BorderRadius.circular(25.0),
                ),
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
            obscureText: true,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != null && value.length < 6
                ? "Password can't be less than 6 characters"
                : null,
            style: TextStyle(color: _textColor),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: _borderColor,
                  width: 1.25,
                ),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: _borderColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: AppStrings.passwordString,
              labelStyle: TextStyle(color: _textColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _borderColor, width: 2.5),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: confirmPasswordController,
            maxLines: 1,
            obscureText: true,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != passwordController.text.trim()
                ? "Type the same password in the confirm field"
                : null,
            style: TextStyle(color: _textColor),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: _borderColor,
                  width: 1.25,
                ),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: _borderColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: AppStrings.confirmPasswordString,
              labelStyle: TextStyle(color: _textColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _borderColor, width: 2.5),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
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
        //   margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        //   child: FloatingActionButton.extended(
        //     heroTag: AppStrings.heroRegister,
        //     backgroundColor: _midWhite,
        //     label: Text(
        //       AppStrings.createAccountButton,
        //       style:
        //           TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        //     ),
        //     onPressed: () => {
        //     signUp()
        //     },
        //     // onPressed: signIn,
        //   ),
        // ),
      ]),
    );
  }

  Future signUp() async {
    await prefs.setBool(AppStrings.isSetBasicInfo, false);

    Fluttertoast.cancel();
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      Fluttertoast.showToast(msg: "Fill the form correctly",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red
      );

      return;
    }

    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => Center(child: slider()),
    // );

    Random random = Random();
    List booleanList = [true,false];
    var firstName = (AppStrings.firstNamesList.toList()..shuffle()).first;
    var lastName=  (AppStrings.lastNamesList.toList()..shuffle()).first;

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ).then((value) async {
          User? user = FirebaseAuth.instance.currentUser;
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user?.uid)
              .set({
            AppStrings.listOfFavouritesKey        : [],
            AppStrings.userUidKey                 : user!.uid,//TODO: TEXT CONTROLLER
            AppStrings.firstNameKey               : "...", //TODO: TEXT CONTROLLER
            AppStrings.familyNameKey              : "...",
            AppStrings.imageKey                   : null, //TODO: GET THIS LATER
            AppStrings.accountCreationTimeStampKey: DateTime.now().millisecondsSinceEpoch,
            AppStrings.phoneNumberKey             : random.nextInt(123456789),
            AppStrings.emailKey                   : emailController.text.trim().toString(),
            AppStrings.jobsPaidPhysicallyKey      : 0,
            AppStrings.jobsPaidThroughAppKey      : 0,
            AppStrings.isVerifiedByIdKey          : (booleanList.toList()..shuffle()).first,
            AppStrings.numberOfFavouritesKey      : 0,
            AppStrings.numberOfReviewsKey         : 0,
            AppStrings.locationKey                : (AppStrings.locationsList.toList()..shuffle()).first,
          });
      });
      Fluttertoast.showToast(msg: AppStrings.userRegistered,
      backgroundColor: Colors.green, toastLength: Toast.LENGTH_SHORT);
      // navigatorKey.currentState!.popUntil((route) => route.isFirst);
      // navigatorKey.currentState!.popUntil((route) => route.isFirst);


      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     '/dashboard or login', (Route<dynamic> route) => false);

      Navigator.push(context, MaterialPageRoute(builder: (context) => SetPersonalDetails(false)));

    } catch (e) {
      debugPrint("Sign up error: " + e.toString());
      Fluttertoast.showToast(msg: AppStrings.userRegistered,
          backgroundColor: Colors.red, toastLength: Toast.LENGTH_LONG);
    }


        // await FirebaseFirestore.instance.collection('users')
        // .doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) async {
        //   for (var element in value.docs)
        // }
        // );

  }



}
