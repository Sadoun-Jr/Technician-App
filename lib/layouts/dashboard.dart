import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:technicians/utils/hex%20colors.dart';

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
      drawer: drawer(),
      drawerScrimColor: Colors.transparent,
      appBar: AppBar(
      elevation: 0.0,
      title: Text("widget.title"),
    ),
    );
  }

  Widget drawer() {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        child: Container(
          width: 250,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(180, 250, 250, 250),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(31, 38, 135, 0.4),
                blurRadius: 8.0,
              )
            ],
          ),
          child: Stack(
            children: [
              SizedBox(
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 4.0,
                      sigmaY: 4.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.grey.withOpacity(0.0),
                          Colors.white.withOpacity(0.2),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  DrawerHeader(
                    child: Row(
                      children: const [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/men/46.jpg"),
                          radius: 30.0,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text("User Name")
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(
                                Icons.favorite,
                                color: Colors.black,
                              ),
                              title: Text("My Favourites"),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(
                                Icons.reviews,
                                color: Colors.black,
                              ),
                              title: Text("My Reviews"),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                              title: Text("Settings"),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(
                                Icons.logout,
                                color: Colors.black,
                              ),
                              title: Text("Log Out"),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          ),
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
            // child: Center(
            //   child: pendingOrdersBox(),
            // ),
          ),
          Container(
            child: circleInBoxLayoutStats(
                quizzesCompleted, QUIZZES_COMPLETED, totalScore, TOTAL_SCORE),
          ),
          Container(
            child: circleInBoxLayoutStats(
                correctAnswers, CORRECT_ANSWERS, wrongAnswers, WRONG_ANSWERS),
          ),
        ]));
  }

  Widget circleInBoxLayoutStats(
      int firstNumber, String firstStat, int secondNumber, String secondStat) {
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

  Widget backGroundSquareForStats(int number, String stat) {
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3,
      child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          color: Colors.transparent,
          child: Center(
            child: Text("Pending orders"),
          )),
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
