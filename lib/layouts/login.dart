import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:technicians/layouts/choose%20register%20method.dart';
import 'package:technicians/layouts/onboarding%20selection%20process.dart';
import 'package:technicians/layouts/pending%20and%20completed%20orders.dart';
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
              return dashBoard();
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
                    child: Lottie.asset(
                        'assets/29410-technical-assistance.json'),
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
        "assets/cyan_bg.jpg",
        fit: BoxFit.fitHeight,
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

    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => Center(child: slider()),
    // );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()
      );

      var collection = FirebaseFirestore.instance.collection("users");
      User? user = FirebaseAuth.instance.currentUser;
      var docSnapshot = await collection.doc(user?.uid).get();
      debugPrint("Role is ""${docSnapshot["role"]} for user ${docSnapshot["email"]}");

      Fluttertoast.showToast(
          backgroundColor: Colors.green,
          msg: "Logged in Successfully as ${FirebaseAuth.instance.currentUser?.email}",
          toastLength: Toast.LENGTH_LONG);

    } catch (e) {

      debugPrint(e.toString());
      Fluttertoast.showToast(
          backgroundColor: Colors.red,
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG);
    }

    // Navigator.pop(context);
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
      MaterialPageRoute(builder: (context) => OnboardingSelection()),
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
/////////////////////////////START DASHBOARD////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  @override
  Widget dashBoard() {
    return Scaffold(
      body: dashboardLayout(),
      bottomNavigationBar: bottomButtonsBar(),
      drawer: NavDrawer(),
      drawerScrimColor: Colors.transparent,
      //TODO: remove the appBar
      appBar: AppBar(
        elevation: 0.0,
        title: Text("widget.title"),
      ),
    );
  }

  Widget dashboardLayout() {
    return Container(
      color: Colors.green,
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Center(
                child: welcomeBackRectangleWithText(),
              )),
          Container(
            child: dashBoardBody(),
          ),
          //TODO: check that this bottom bar is actually stuck at the bottom of screen
          //DO NOT USE SPACER() HERE BECAUSE IT CAN CAUSE RENDER ISSUES
        ],
      ),
    );
  }

  Widget welcomeBackRectangleWithText() {
    return Container(
        padding: const EdgeInsets.all(7),
        height: 100.0,
        width: double.infinity,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          child: Center(
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(7),
                      child: const Text(
                        "Welcome back, WIDGET",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )),
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 36,
                    ),
                  ),
                ],
              )),
        ));
  }

  Widget dashBoardBody() {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        width: double.infinity,
        color: Colors.transparent,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadius))),
            child: Center(
              child: pendingOrdersBox(),
            ),
          ),
          Container(
            child: circleInBoxLayoutStats(
                34, "Jobs", 4500, "Paid"),
          ),
          Container(
            child: circleInBoxLayoutStats(
                4.8, "Rating", 00, "..."),
          ),
        ]));
  }

  Widget circleInBoxLayoutStats(
      double firstNumber, String firstStat, double secondNumber, String secondStat) {
    return Container(
      height: 220.0,
      color: secondaryColor,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            Flexible(
              child: backGroundSquareForStats(firstNumber, firstStat),
              flex: 1,
            ),
            Flexible(
              child: backGroundSquareForStats(secondNumber, secondStat),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget backGroundSquareForStats(double number, String stat) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: const EdgeInsets.all(15),
      height: 200.0,
      decoration: BoxDecoration(
          color: primColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      child: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                radius: 50,
                child: Center(
                  child: Text(
                    "$number",
                    style: TextStyle(
                        fontSize: 20,
                        color: primColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    stat,
                    style: const TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget bottomButtonsBar() {
    return
     Container(
       margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
       child: FloatingActionButton.extended(
         heroTag: 100,
         backgroundColor: _primaryColor,
           splashColor: Colors.white,
           onPressed: () => Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => OnboardingSelection()),
           ),
           label: Text("Create a new order")),
     ) ;
      // Container(
      //   color: Colors.white,
      //   child: Container(
      //       margin: EdgeInsets.fromLTRB(40, 0, 40, 5),
      //       child: Row(
      //         children: [
      //           bottomhalfButton("Logout", Icons.logout, () => {}),
      //           Spacer(),
      //           bottomhalfButton(
      //               "Quiz", Icons.question_mark, () => {}),
      //           Spacer(),
      //           bottomhalfButton("Share", Icons.share, null)
      //         ],
      //       )));
  }

  Widget bottomhalfButton(String text, IconData icon, VoidCallback? function) {
    return Container(
        child: SizedBox.fromSize(
          size: Size(60, 60),
          child: ClipOval(
            child: Material(
              color: (HexColor("#ffffff")),
              child: InkWell(
                splashColor: Colors.blueGrey,
                onTap: function,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.blue,
                    ), // <-- Icon
                    Text(
                      text,
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ), // <-- Text
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget pendingOrdersBox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: HexColor("#D4AF37")
            ),
            height: 50,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                onTap: () => navigateToPendingOrCompletedOrders(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Pending orders (1)")),
                ),
              ),
            )),
        Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.green
            ),
            height: 50,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                onTap: () => navigateToPendingOrCompletedOrders(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Completed orders")),
                ),
              ),
            )),
      ],
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
