import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technicians/layouts/payment%20options.dart';
import 'package:technicians/layouts/pending%20and%20completed%20orders.dart';
import 'package:technicians/layouts/set%20personal%20details.dart';
import 'package:technicians/layouts/stats.dart';
import 'package:technicians/layouts/stepper.dart';
import 'package:technicians/layouts/welcome.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/widgets/glass%20box.dart';
import 'package:technicians/widgets/navigation%20drawer.dart';
import 'package:technicians/widgets/slider.dart';
import '../models/consumer object.dart';
import '../utils/strings enum.dart';
import '../widgets/logo.dart';

class LoginLayout extends StatefulWidget {
  const LoginLayout({Key? key}) : super(key: key);

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

Color _primaryColor = HexColor("##1651db");
Color _textClr = HexColor("#052163");
Color _borderColor = HexColor("#0d3fb5");
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class _LoginLayoutState extends State<LoginLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return selectionScreen();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
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
                        "Loading...",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          );
        } else {
          return loginLayout();
        }
      },
    ));
  }

  @override
  void initState() {
    super.initState();
    loginImg = AssetImage('assets/login anim.gif');
  }

  @override
  void dispose() {
    super.dispose();
    loginImg.evict();
  }

  final Color _darkTxtClr = HexColor("#96878D");
  final Color _btnColor = HexColor("#96878D");
  late AssetImage loginImg;

  Widget loginLayout() {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
        return false;
      },
      child: Stack(
        children: [
          loginLayoutBackGroundImage(),
          // Align(
          //     alignment: Alignment.topCenter,
          //     child: Hero(
          //       tag: "lottie",
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.vertical(
          //             bottom: Radius.elliptical(
          //                 MediaQuery.of(context).size.width, 32)),
          //         child: Image(image: loginImg,),
          //       ),
          //     )),
          Align(
            child: glassyLoginBox(),
            alignment: Alignment.bottomCenter,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // decoration: BoxDecoration(
              //   border: Border.all(width: 2, color: Colors.brown)
              // ),
              width: 310,
              margin: EdgeInsets.fromLTRB(0, 40, 0, 130),
              child: FloatingActionButton.extended(
                heroTag: AppStrings.heroLogin,
                splashColor: Colors.white,
                backgroundColor: _btnColor,
                label: Text(
                  AppStrings.loginString,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                onPressed: signIn,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 40, 0, 80),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                child: Text(
                  AppStrings.forgotPassword,
                  style: TextStyle(color: _darkTxtClr),
                ),
                onPressed: () => {},
              ),
            ),
          )
          // loginBoxContents(),
        ],
      ),
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
    return Hero(
      tag: "box",
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 60),
          decoration: BoxDecoration(
            border: Border.all(width: 0, color: Colors.white),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: FrostedGlassBox(
            350,
            double.infinity,
            Center(child: loginBoxContents()),
          ),
        ),
      ),
    );
  }

  Widget loginBoxContents() {
    return SingleChildScrollView(
      child: Column(children: [
        // Container(
        //   alignment: Alignment.center,
        //   margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        //   child: Text(
        //     AppStrings.loginString,
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
            controller: _emailController,
            maxLines: 1,
            style: TextStyle(color: _textClr),
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
              labelStyle: TextStyle(color: Colors.black54),
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
            controller: _passwordController,
            maxLines: 1,
            obscureText: true,
            style: TextStyle(color: _textClr),
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
              labelStyle: TextStyle(color: Colors.black54),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _darkTxtClr, width: 2.5),
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
          margin: const EdgeInsets.fromLTRB(20, 40, 20, 10),
        ),
      ]),
    );
  }

  Future signIn() async {
    prefs = await SharedPreferences.getInstance();
    Fluttertoast.cancel();

    //check if there is connection
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "No internet connection", backgroundColor: Colors.red);
      return;
    }

    //show loading animation while signing in
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Material(
          child: Stack(
        children: [
          Image.asset(
            "assets/abstract bg.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 125,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Lottie.asset('assets/loading gear.json',
                        height: 75,
                        width: 75,
                        alignment: Alignment.center,
                        animate: true),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Signing in",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ],
      )),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim());

      var collection = FirebaseFirestore.instance.collection("users");
      User? user = FirebaseAuth.instance.currentUser;

      await collection
          .where(AppStrings.userUidKey, isEqualTo: user!.uid)
          .get()
          .then((value) async {
        //get user info and save it in prefs
        for (var element in value.docs) {
          await prefs!.setString(AppStrings.currentUserFirstName,
              element.data()[AppStrings.firstNameKey] ?? '');
          await prefs!.setString(AppStrings.currentUserFamilyName,
              element.data()[AppStrings.familyNameKey] ?? '');
          await prefs!.setString(AppStrings.currentUserProfilePicLink,
              element.data()[AppStrings.imageKey] ?? 'na');
          await prefs!.setString(AppStrings.currentUserGender,
              element.data()[AppStrings.genderKey] ?? '');
          await prefs!.setInt(AppStrings.currentUserAge,
              element.data()[AppStrings.ageKey] ?? 0);
          await prefs!.setString(AppStrings.currentUserProvince,
              element.data()[AppStrings.locationKey] ?? '');
          await prefs!.setString(AppStrings.currentUserCity,
              element.data()[AppStrings.subLocationKey] ?? '');
          await prefs!.setInt(AppStrings.currentUserPhoneNumber,
              element.data()[AppStrings.currentUserPhoneNumber] ?? 0);
          await prefs!.setString(AppStrings.currentUserAddress,
              element.data()[AppStrings.addressKey] ?? '');
        }

        //check if user is first time or not and state it
        prefs!.setBool(
            AppStrings.isFirstTimeUser,
            prefs!.getString(AppStrings.currentUserFirstName) == ''
                ? true
                : false);
      });

      Fluttertoast.showToast(
          backgroundColor: Colors.green,
          msg:
              "Logged in Successfully as ${FirebaseAuth.instance.currentUser?.email}",
          toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
          backgroundColor: Colors.red,
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG);
    }

    //user logged in, get info from db and fill prefs

    Navigator.pop(context);
  }

  void navigateToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
  }

  void navigateToOnboardingSelection() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StepperProcess()),
    );
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////END LOGIN//////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////START SELECTION////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  SharedPreferences? prefs;
  bool accessDataAnimation = true;

  Future<void> initalisePrefs() async {
    prefs = await SharedPreferences.getInstance();
    hasSetProfileInfo = prefs!.getBool(AppStrings.hasSetProfileInfo)!;
  }

  void getUserData() {
    prefs!.getString(AppStrings.currentUserFirstName);
    prefs!.getString(AppStrings.currentUserFamilyName);
    prefs!.getString(AppStrings.currentUserProfilePicLink);
    debugPrint('link method: ${prefs!.getString(AppStrings.currentUserProfilePicLink)}');

  }

  Widget selectionScreen() {
    // debugPrint('profile pic link: ${prefs?.getString(AppStrings.currentUserProfilePicLink)}');
    return FutureBuilder(
      future: initalisePrefs(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        //========disabled for testing purposes only, its working===========
        // if (snapshot.connectionState == ConnectionState.done &&
        //     !hasSetProfileInfo) {
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => SetPersonalDetails(
        //             false,
        //             true,
        //             gender: null,
        //             city: null,
        //             age: null,
        //             profilePicLink: null,
        //             firstName: null,
        //             familyName: null,
        //             province: null,
        //             phoneNumber: null,
        //           )));
        // });
        //
        // return Text('');
        // }
        // else
        if (snapshot.connectionState == ConnectionState.done) {
          getUserData();
          debugPrint('link: ${prefs!.getString(AppStrings.currentUserProfilePicLink)}');
          return Scaffold(
              extendBodyBehindAppBar: true,
              drawer: NavDrawer(),
              appBar: AppBar(
                title: Row(
                  children: [
                    prefs!.getString(AppStrings.currentUserProfilePicLink) ==
                            'na'
                        ? Container(
                            height: 45.5,
                            width: 45.5,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              Icons.person,
                              size: 35.5,
                              color: Colors.black12,
                            ))
                        : Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white70,
                              maxRadius: 28.5,
                              backgroundImage: NetworkImage(prefs!.getString(
                                  AppStrings.currentUserProfilePicLink)!),
                              // child: Image.network(
                              //   myAssignedTech!.image!, height: 125, width: 125,),
                            ),
                          ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      prefs!.getString(AppStrings.currentUserFirstName)! +
                          " " +
                          prefs!.getString(AppStrings.currentUserFamilyName)!,
                      style: TextStyle(color: Colors.black54),
                    )
                  ],
                ),
                toolbarHeight: 80,
                iconTheme: IconThemeData(color: Colors.black54, size: 25),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Stack(children: [
                Hero(
                  tag: "bg",
                  child: Image.asset(
                    "assets/abstract bg.jpg",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                ),
                Center(
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: circleBtn("assets/dash fix.png", "Order",
                                  Colors.red[200], "123124", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StepperProcess()),
                            );
                          })),
                          Flexible(
                              child: circleBtn("assets/dash wiat.png",
                                  "Pending", Colors.yellow[200], "2314", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PendingAndCompletedOrders()),
                            );
                          }))
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: circleBtn("assets/dash done 2.png", "Done",
                                  Colors.green[200], "12", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentOptions()),
                            );
                          })),
                          Flexible(
                            child: circleBtn("assets/dash stats 2.png", "Stats",
                                Colors.grey[200], "1", () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Stats()),
                              );
                            }),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ]));
        } else {
          return Stack(
            children: [
              Image.asset(
                "assets/abstract bg.jpg",
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Lottie.asset('assets/loading gear.json',
                            height: 75,
                            width: 75,
                            alignment: Alignment.center,
                            animate: true),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Loading account data...",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget circleBtn(String image, String text, Color? spalshClr, String tag,
      VoidCallback function) {
    return Hero(
      tag: tag,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 27),
          child: Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(150)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: spalshClr,
                      onTap: function,
                      child: Container(
                        width: double.infinity,
                        height: 145,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            border: Border.all(width: 3, color: Colors.white54),
                            color: Colors.white.withOpacity(0.3)),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Image.asset(
                                image,
                                height: 40,
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Flexible(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  text,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            )
                          ],
                        )),
                      ),
                    ),
                  ),
                ),
              ))),
    );
  }

  void navigateToPendingOrCompletedOrders() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PendingAndCompletedOrders()),
    );
  }

  bool hasSetProfileInfo = true;
  String schoolName = "TEXAS SCHOOL";
  String LOGIN_SCREEN_HEADER = "Sign in portal";
  String register = "Register";
  String userName = "User Name";
  String EMAIL = "Email";
  String passWord = "Password";
  String FORGOT_PASSWORD = "Forgot Password";
  String LOGIN = "LOGIN";
  String noAccountRegisterPlease = "Don't have an account?";
  var name = "";
  var finishedGrabbingName = false;
  String LOGOUT = "LOGOUT";
  String QUIZ_LIST = "QUIZ LIST";
  String STUDENT_RANK = "Student Rank";
  String QUIZZES_COMPLETED = "Quizzes";
  String TOTAL_SCORE = "Total Score";
  String CORRECT_ANSWERS = "Correct Ans.";
  String WRONG_ANSWERS = "Wrong Ans.";
  var quizzesCompleted = 22;
  var totalScore = 521;
  var correctAnswers = 442;
  var wrongAnswers = 21;
  var ranking = 23;
  var borderRadius = 50.0;
  Color primColor = HexColor("#001f3e");
  Color secondaryColor = Colors.white;
  bool? isAdminBool = null;
  String CREATE_NEW_QUIZ = "Create a new quiz";
  String EDIT_QUIZ = "Edit existing quiz";
  String DELETE_QUIZ = "Delete existing quiz";
  String LIST_STUDENTS = "Quiz Stats";
  String role = "user";
  Widget _body = Container(child: Text("DDDDDDDDD")); // Default Body
}
