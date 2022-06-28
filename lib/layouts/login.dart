import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:technicians/layouts/choose%20register%20method.dart';
import 'package:technicians/layouts/pending%20and%20completed%20orders.dart';
import 'package:technicians/layouts/stats.dart';
import 'package:technicians/layouts/stepper.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/widgets/glass%20box.dart';
import 'package:technicians/widgets/navigation%20drawer.dart';
import 'package:technicians/widgets/slider.dart';
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
          return CircularProgressIndicator();
        } else {
          return loginLayout();
        }
      },
    ));
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
                    height: 300,
                    width: 300,
                    child: Lottie.asset('assets/intro_abstract_anime.json'),
                  ),
                ),
              ],
            )),
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
              backgroundColor: _primaryColor,
              label: Text(
                AppStrings.loginString,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                style: TextStyle(color: _textClr),
              ),
              onPressed: () => {},
            ),
          ),
        )
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
    return Hero(
      tag: "box",
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 60),
          decoration: BoxDecoration(
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
              labelStyle: TextStyle(color: Colors.black54),
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
            controller: _passwordController,
            maxLines: 1,
            obscureText: true,
            style: TextStyle(color: _textClr),
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
              labelStyle: TextStyle(color: Colors.black54),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _borderColor, width: 2.5),
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
          // child: FloatingActionButton.extended(
          //   heroTag: AppStrings.heroLogin,
          //   splashColor: Colors.white,
          //   backgroundColor: _primaryColor,
          //   label: Text(
          //     AppStrings.loginString,
          //     style:
          //         TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          //   ),
          //   onPressed: signIn,
          // ),
        ),

        // TextButton(
        //   child: Text(
        //     AppStrings.forgotPassword,
        //     style: TextStyle(color: _textClr),
        //   ),
        //   onPressed: () => {},
        // )
      ]),
    );
  }

  Future signIn() async {
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

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Material(
        child: Center(
            child: Container(
          height: 150,
          width: 150,
          child: Lottie.asset('assets/loading.json'),
        )),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      var collection = FirebaseFirestore.instance.collection("users");
      User? user = FirebaseAuth.instance.currentUser;
      var docSnapshot = await collection.doc(user?.uid).get();
      debugPrint(
          "Role is " "${docSnapshot["role"]} for user ${docSnapshot["email"]}");

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

    Navigator.pop(context);
  }

  void navigateToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectRegisterMethodLayout()),
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
int xyz = 4;
  Widget selectionScreen() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Row(
          children: const [
            CircleAvatar(
              backgroundColor: Colors.grey,
              maxRadius: 30,
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              "Ahmed Selim",
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
        toolbarHeight: 80,
        iconTheme: IconThemeData(color: Colors.black54, size: 25),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
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
                                MaterialPageRoute(builder: (context) => StepperProcess()),
                              );
                            }
                        )),
                    Flexible(
                        child: circleBtn("assets/dash wiat.png", "Pending",
                            Colors.yellow[200], "2314",
                                () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PendingAndCompletedOrders()),
                              );
                            }))
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                        child: circleBtn("assets/dash done 2.png", "Done",
                            Colors.green[200], "12",
                                () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Stats()),
                              );
                            })),
                    Flexible(
                      child: circleBtn("assets/dash stats 2.png", "Stats",
                          Colors.grey[200], "1", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Stats()),
                        );
                      }),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget circleBtn(String image, String text, Color? spalshClr, String tag,
      VoidCallback function) {
    return Hero(
      tag: tag,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Align(
              alignment: Alignment.topCenter,
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
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            border: Border.all(width: 1, color: Colors.white54),
                            color: Colors.grey.shade200.withOpacity(0.25)),
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
