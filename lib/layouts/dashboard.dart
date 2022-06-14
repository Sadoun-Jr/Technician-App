import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:technicians/layouts/pending%20and%20completed%20orders.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/widgets/navigation%20drawer.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
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
    return Container(
        color: Colors.white,
        child: Container(
            margin: EdgeInsets.fromLTRB(40, 0, 40, 5),
            child: Row(
              children: [
                bottomhalfButton("Logout", Icons.logout, () => {}),
                Spacer(),
                bottomhalfButton(
                    "Quiz", Icons.question_mark, () => {}),
                Spacer(),
                bottomhalfButton("Share", Icons.share, null)
              ],
            )));
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: HexColor("#D4AF37")
          ),
          height: 140,
            width: 140,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                onTap: () => navigateToPendingOrCompletedOrders(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Pending orders\n(1)")),
                ),
              ),
            )),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.green
            ),
            height: 140,
            width: 140,
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

  navigateToPendingOrCompletedOrders() {
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
