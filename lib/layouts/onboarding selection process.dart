import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:technicians/layouts/dashboard.dart';
import 'package:technicians/layouts/technician%20reviews.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'package:technicians/widgets/glass%20box.dart';
import 'package:technicians/widgets/navigation%20drawer.dart';

class OnboardingSelection extends StatefulWidget {
  const OnboardingSelection({Key? key}) : super(key: key);

  @override
  State<OnboardingSelection> createState() => _OnboardingSelectionState();
}

class _OnboardingSelectionState extends State<OnboardingSelection> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

var prioritySelected = false;
var isNextButtonVisible = false;
var isCategoryChosen = false;
var isSortedByAppliance = true;
var isSortedByTrades = false;
var isHeaderVisible = false;

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pop(context);
  }

  void switchNextButtonVisibility(bool visibile) {
    if (visibile) {
      isNextButtonVisible = true;
    } else {
      isNextButtonVisible = false;
    }
    setState(() => isCategoryChosen = true);
  }

  void nextPage() {
    introKey.currentState?.next();
  }

  void skipPages() {
    introKey.currentState?.skipToEnd();
  }

  //use the library read me as a reference
  //https://pub.dev/packages/introduction_screen
  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    return Scaffold(
      drawer: NavDrawer(),
      drawerScrimColor: Colors.transparent,
      //TODO: remove the appBar
      appBar: AppBar(
        elevation: 0.0,
        title: Text("widget.title"),
      ),
      body: Stack(children: [
        Image.asset(
          "assets/blurred_login.png",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.transparent,
          globalHeader: Visibility(
            visible: isHeaderVisible,
            child: Container(
              margin: EdgeInsets.fromLTRB(60, 40, 60, 20),
              child: Row(
                children: [
                  FloatingActionButton.extended(
                      onPressed: sortByTrades, label: Text("Appliances")),
                  Spacer(),
                  FloatingActionButton.extended(
                      onPressed: sortByApplicances, label: Text("Trades"))
                ],
              ),
            ),
          ),

          rawPages: [
            selectEmergencyOnboarding(),
            selectCategoryOnboarding(),
            selectIssueTypeOnboarding(selectKindOfIssuesArray()),
            selectTechnicianOnboarding(),
            selectAppointmentTimeOnboarding(),
          ],
          onDone: () => _showMyDialog(),
          //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
          skipOrBackFlex: 0,
          nextFlex: 0,
          //prevent scrolling by swiping
          // freeze: true,

          isProgressTap: false,
          showNextButton: true,
          showSkipButton: false,
          freeze: true,
          showBackButton: true,
          onChange: (page) {
            if (page == 1) {
              setState(() => isHeaderVisible = true);
            } else {
              setState(() => isHeaderVisible = false);
            }
          },

          // showNextButton: false,
          // rtl: true, // Display as right-to-left
          back: const Icon(Icons.arrow_back),
          skip:
              const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
          next: Icon(
            Icons.arrow_forward,
          ),

          done:
              const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ]),
    );
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////START DIALOGUE/////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              side: BorderSide(color: Colors.green, width: 3)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  height: 150,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(40),
                  child: Text(
                    'Awesome',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Text(
                        'The technician has been notified with your request')),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(40),
                  child: FloatingActionButton.extended(
                      //TODO: set a key here to prevent user from multiple requests
                      label: Text("To dashboard"),
                      onPressed: () => {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/dashboard', (Route<dynamic> route) => false)
                          }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////END DIALOGUE///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////START PAGE 5///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  Widget selectAppointmentTimeOnboarding() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 16, 20, 80),
      child: ListView(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true, // use this
        children: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2)),
              child: Icon(
                Icons.person,
                size: 250,
              )),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white54),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Hamad",
                        maxLines: 1,
                        style: TextStyle(fontSize: 20),
                      )),
                  SizedBox(height: 5),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "This is somewhat a medium sized description of the technician",
                        maxLines: 2,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: FloatingActionButton.extended(
                              heroTag: 3,
                              label: Text("Reviews"),
                              onPressed: () => {
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TechnicianReviews()),
                              )
                              }),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton.extended(
                              heroTag: 2,
                              label: Text("portfolio"),
                              onPressed: () => {})),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: 150,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white54),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Appointment selection here",
                    maxLines: 1,
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FrostedGlassBox(
                  100,
                  100,
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "53",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text("Jobs"),
                      )
                    ],
                  ))),
              FrostedGlassBox(
                  100,
                  100,
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "4.5",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text("Rating"),
                      )
                    ],
                  ))),
              FrostedGlassBox(
                  100,
                  100,
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "99%",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text("Completion"),
                      )
                    ],
                  ))),
            ],
          ),
        ],
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////END PAGE 5/////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////START PAGE 4///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  int selectTechnicianValue = -1;

  Widget selectTechnicianOnboarding() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 80),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppStrings.selectTechnicianString,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: AppStrings.techniciansList.length,
                itemBuilder: (context, index) {
                  return Container(
                      height: 100,
                      padding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 4),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          splashColor: Colors.redAccent,
                          onTap: () =>
                              setState(() => selectTechnicianValue = index),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                                color: selectTechnicianValue == index
                                    ? Colors.redAccent
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Row(children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 16,
                                    ),
                                    CircleAvatar(
                                      // backgroundImage:
                                      // AppStrings.techniciansList[index].image,
                                      backgroundColor: Colors.grey,
                                      maxRadius: 30,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 23, 16, 16),
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              AppStrings
                                                  .techniciansList[index].name,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              AppStrings
                                                  .techniciansList[index].desc,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppStrings.techniciansList[index].rating,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: AppStrings
                                                      .techniciansList[index]
                                                      .availability ==
                                                  "Available"
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(5, 0, 16, 0),
                                      child: Icon(
                                        Icons.star,
                                        size: 16,
                                        color: HexColor("FFD700"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ));
                }),
          )
        ],
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////END PAGE 4/////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////START PAGE 3///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  List<String> selectKindOfIssuesArray() {
    List<String> returnedList = [];

    if (selectCategoryValue == 2) {
      returnedList = AppStrings.plumberIssues;
    } else if (selectCategoryValue == 5) {
      returnedList = AppStrings.carpenterIssues;
    } else {
      returnedList = ["no", "issue", "found"];
    }

    return returnedList;
  }

  int selectIssueValue = -1;

  Widget selectIssueTypeOnboarding(List<String> listOfIssues) {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 80, 40, 80),
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: listOfIssues.length,
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() => selectIssueValue = index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: selectIssueValue == index
                          ? Colors.grey
                          : Colors.transparent,
                    ),
                    child: Center(
                        child: Text(
                      listOfIssues[index],
                      maxLines: 1,
                    )),
                  ),
                ),
              ),
            );
          }),
    );
  }

  int selectCategoryValue = -1;

  Widget selectCategoryOnboarding() {
    return Container(
        margin: EdgeInsets.fromLTRB(40, 100, 40, 80),
        child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              appliancesItemRow(1, "Electricians", 2, "Plumbers"),
              appliancesItemRow(3, "Builders", 4, "Painters"),
              appliancesItemRow(5, "Carpenters", 6, "Cleaners"),
              appliancesItemRow(7, "Butcher", 8, "Mechanic"),
              appliancesItemRow(9, ".....", 10, "....."),
              tradesItemRow(101, "AC", 102, "Refrigirator"),
              tradesItemRow(103, "Computer", 104, "Dry Cleaner"),
              tradesItemRow(105, "Drier", 106, "Mobile phone"),
              tradesItemRow(107, "Drier", 108, "other"),
              tradesItemRow(109, "/////", 1010, "/////"),
            ]));
  }
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////END ONBOARDING PAGE 3//////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////START ONBOARDING PAGE 2////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  void sortByApplicances() {
    isSortedByTrades = false;
    setState(() => isSortedByAppliance = true);
  }

  void sortByTrades() {
    isSortedByAppliance = false;
    setState(() => isSortedByTrades = true);
  }

  void categorySelected() {
    isNextButtonVisible = true;
    setState(() => isCategoryChosen = true);
  }

  Widget appliancesItemRow(int selectedValueFirst, String textFirst,
      int selectedValueSecond, String textSecond) {
    return Visibility(
      visible: isSortedByAppliance,
      child: Row(
        children: [
          Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: InkWell(
              onTap: () =>
                  setState(() => selectCategoryValue = selectedValueFirst),
              child: Container(
                height: 56,
                width: 56,
                child: Center(child: Text(textFirst)),
                decoration: BoxDecoration(
                    color: selectCategoryValue == selectedValueFirst
                        ? Colors.grey
                        : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
            ),
          ),
          Spacer(),
          Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: InkWell(
              onTap: () =>
                  setState(() => selectCategoryValue = selectedValueSecond),
              child: Container(
                height: 56,
                width: 56,
                child: Center(child: Text(textSecond)),
                decoration: BoxDecoration(
                  color: selectCategoryValue == selectedValueSecond
                      ? Colors.grey
                      : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tradesItemRow(int selectedValueFirst, String textFirst,
      int selectedValueSecond, String textSecond) {
    return Visibility(
      visible: isSortedByTrades,
      child: Row(
        children: [
          Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: InkWell(
              onTap: () =>
                  setState(() => selectCategoryValue = selectedValueFirst),
              child: Container(
                height: 56,
                width: 56,
                child: Center(child: Text(textFirst)),
                decoration: BoxDecoration(
                    color: selectCategoryValue == selectedValueFirst
                        ? Colors.grey
                        : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
            ),
          ),
          Spacer(),
          Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: InkWell(
              onTap: () =>
                  setState(() => selectCategoryValue = selectedValueSecond),
              child: Container(
                height: 56,
                width: 56,
                child: Center(child: Text(textSecond)),
                decoration: BoxDecoration(
                  color: selectCategoryValue == selectedValueSecond
                      ? Colors.grey
                      : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////END ONBOARDING PAGE 2//////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////START ONBOARDING PAGE 1////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  void turnOnPrioritySelected() {
    isNextButtonVisible = true;
    setState(
      () => prioritySelected = true,
    );
  }

  Widget selectEmergencyOnboarding() {
    return Container(
      margin: EdgeInsets.all(30),
      child: ListView(
        children: [
          SizedBox(
            height: 100,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              AppStrings.selectPriorityString,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          FloatingActionButton.extended(
              backgroundColor: Colors.red,
              icon: Icon(Icons.emergency),
              heroTag: 1,
              onPressed: nextPage,
              label: Text(AppStrings.immediately)),
          SizedBox(height: 20),
          FloatingActionButton.extended(
              backgroundColor: Colors.blueGrey,
              heroTag: 2,
              icon: Icon(Icons.lock_clock),
              onPressed: skipPages,
              label: Text(AppStrings.appointment)),
        ],
      ),
    );
  }
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////END ONBOARDING PAGE 1//////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

}
