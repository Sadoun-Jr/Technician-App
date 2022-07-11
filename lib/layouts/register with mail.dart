import 'dart:io';
import 'dart:math';
import 'dart:ui';

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
import 'intro onboarding.dart';
import 'welcome.dart';

class RegisterWithMailLayout extends StatefulWidget {
  const RegisterWithMailLayout({Key? key}) : super(key: key);

  @override
  State<RegisterWithMailLayout> createState() => _RegisterWithMailLayoutState();
}

class _RegisterWithMailLayoutState extends State<RegisterWithMailLayout> {
  final Color _textColor = HexColor("#052163");
  final Color _borderColor = HexColor("#0d3fb5");
  final Color _primaryColor = HexColor("##1651db");
  final Color _darkTxtClr = HexColor("#96878D");

  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late var prefs;
  bool isRegistering = false;

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
      home: WillPopScope(
        onWillPop: () async{
          // Navigator.pop(context);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => WelcomeScreen()),
          // );
          return true;
        },
        child: Scaffold(
          body: isRegistering ?  SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Image.asset(
                  "assets/abstract bg.jpg",
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Lottie.asset('assets/loading gear.json',
                            height: 75,
                            width: 75,
                            alignment: Alignment.bottomCenter,
                            animate: true),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Creating account",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ) : (loginLayout()),
        ),
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
                    height: 150,
                    width: 150,
                    child: Lottie.asset(
                        'assets/29410-technical-assistance.json'),
                  ),
                ),
              ],
            )),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
          child: Align(
            child: glassyLoginBox(),
            alignment: Alignment.bottomCenter,
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
        "assets/abstract bg.jpg",
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
      child: FrostedGlassBox(
        450,
        double.infinity,
        Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: loginBoxContents())),
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
                fontSize: 24, color: _darkTxtClr, fontWeight: FontWeight.bold),
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
                    color: _darkTxtClr,
                    width: 1.25,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: _darkTxtClr,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: AppStrings.emailString,
                labelStyle: TextStyle(color: _darkTxtClr),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _darkTxtClr, width: 2.5),
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
                  color: _darkTxtClr,
                  width: 1.25,
                ),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: _darkTxtClr,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: AppStrings.passwordString,
              labelStyle: TextStyle(color: _darkTxtClr),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _darkTxtClr, width: 2.5),
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
                  color: _darkTxtClr,
                  width: 1.25,
                ),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: _darkTxtClr,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: AppStrings.confirmPasswordString,
              labelStyle: TextStyle(color: _darkTxtClr),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _darkTxtClr, width: 2.5),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ),
        SizedBox(height: 30,),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.fromLTRB(18, 0, 18, 16),
            child: Visibility(
              visible:MediaQuery.of(context).viewInsets.bottom == 0,
              child: FloatingActionButton.extended(
                heroTag: AppStrings.heroRegister,
                splashColor: Colors.white,
                backgroundColor: _darkTxtClr,
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
      ]),
    );
  }

  Future signUp() async {

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // debugPrint('connected');
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "No internet connection", backgroundColor: Colors.red);
      return;
    }

    setState(() => isRegistering = true);

    // showDialog(context: context, builder:(BuildContext context) {
    //   return Dialog(
    //     backgroundColor: Colors.transparent,
    //     child: Container(
    //         height: 200,
    //         width: MediaQuery.of(context).size.width,
    //         // margin:
    //         // EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //         child: Align(
    //             alignment: Alignment.topCenter,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.all(Radius.circular(30)),
    //               child: BackdropFilter(
    //                 filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.5),
    //                 child: Container(
    //                   padding: EdgeInsets.all(25),
    //                   height: double.infinity,
    //                   width: double.infinity,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.all(Radius.circular(30)),
    //                       border: Border.all(width: 2, color: Colors.white),
    //                       color: Colors.grey.shade200.withOpacity(0.25)),
    //                   child: Column(
    //                     children: [
    //                       Align(
    //                           alignment: Alignment.topCenter,
    //                           child: Text(
    //                             "Delete profile picture?",
    //                             style: TextStyle(
    //                                 color: Colors.white, fontSize: 18),
    //                           )),
    //                       SizedBox(
    //                         height: 12.5,
    //                       ),
    //                       Expanded(
    //                         child: Row(
    //                           mainAxisAlignment:
    //                           MainAxisAlignment.spaceAround,
    //                           children: [
    //                           ],
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ))),
    //   );
    // },);

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
            AppStrings.userUidKey                 : user!.uid,
            AppStrings.firstNameKey               : '',
            AppStrings.familyNameKey              : '',
            AppStrings.imageKey                   : 'na',
            AppStrings.accountCreationTimeStampKey: DateTime.now().millisecondsSinceEpoch,
            AppStrings.phoneNumberKey             : 0,
            AppStrings.emailKey                   : emailController.text.trim().toString(),
            AppStrings.jobsPaidPhysicallyKey      : 0,
            AppStrings.jobsPaidThroughAppKey      : 0,
            AppStrings.isVerifiedByIdKey          : false,
            AppStrings.numberOfFavouritesKey      : 0,
            AppStrings.numberOfReviewsKey         : 0,
            AppStrings.locationKey                : '',
          });
      });
      Fluttertoast.showToast(msg: AppStrings.userRegistered,
      backgroundColor: Colors.green, toastLength: Toast.LENGTH_SHORT);

      // Navigator.pop(context);

      Navigator.push(context, MaterialPageRoute(builder: (context) =>
      IntoOnboarding()));

      // Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //     SetPersonalDetails(false, true, gender: null, city: null, age: null,
      //       profilePicLink: null, firstName: null, familyName: null, province: null,
      //       phoneNumber: null,)));


    } catch (e) {
      // Navigator.pop(context);
      setState(() => isRegistering = false);

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
