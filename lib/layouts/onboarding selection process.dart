import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:technicians/layouts/technician%20reviews.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/utils/strings%20common%20issues.dart';
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
var isHeaderForCategoryPageVisible = false;
var isHeaderForDescPageVisible = false;
var isHeaderForSelectTechnicianListVisible = false;
TextEditingController customIssueController = TextEditingController();
TextEditingController searchTechnicianController = TextEditingController();
Color _whiteText = Colors.white;
Color _midWhite = Colors.white54;

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pop(context);
  }

  // void switchNextButtonVisibility(bool visibile) {
  //   if (visibile) {
  //     isNextButtonVisible = true;
  //   } else {
  //     isNextButtonVisible = false;
  //   }
  //   setState(() => isCategoryChosen = true);
  // }

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
          globalHeader: checkAppropriateGlobalHeader(),
          rawPages: [
            selectEmergencyOnboarding(),
            selectCategoryOnboarding(),
            selectIssueTypeOnboarding(selectKindOfIssuesArray()),
            selectTechnicianOnboarding(),
            selectAppointmentTimeOnboarding(),
          ],
          onDone: requestOrder,
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
          showDoneButton: true,
          onChange: (page) {
            isHeaderForCategoryPageVisible = false;
            isHeaderForDescPageVisible = false;
            isHeaderForSelectTechnicianListVisible = false;

            if (page == 1) {
              setState(() => isHeaderForCategoryPageVisible = true);
            } else if (page == 2) {
              setState(() => isHeaderForDescPageVisible = true);
            } else if (page == 3) {
              setState(() => isHeaderForSelectTechnicianListVisible = true);
            } else {
              setState(() => {});
            }
          },

          // showNextButton: false,
          // rtl: true, // Display as right-to-left
          back: const Icon(Icons.arrow_back),
          skip:
              const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
          next: Visibility(
            visible: isNextButtonVisible,
            maintainState: true,
            maintainSize: true,
            maintainAnimation: true,
            child: Icon(
              Icons.arrow_forward,
            ),
          ),

          done: Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
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

  void requestOrder() async {
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

    try {
      //get the current user uid
      final auth = FirebaseAuth.instance;
      final User user = await auth.currentUser!;
      final userid = user.uid;

      //create an empty issue with a uid
      await FirebaseFirestore.instance.collection("issues").add({
        AppStrings.uidKey: " ",
      }).then((value) async {
        debugPrint(
            "Issue made with ID# " + value.id + "\nCreated by ID# " + user.uid);
        await FirebaseFirestore.instance
            .collection("issues")
            .doc(value.id)
            .set({
          AppStrings.uidKey: value.id,
          AppStrings.completedByKey: AppStrings.notCompletedYet,
          AppStrings.isAcceptedByTechnicianKey: false,
          AppStrings.isCanceledByUserKey: false,
          AppStrings.isCompletedKey: false,
          AppStrings.isEmergencyKey: _isEmergency,
          AppStrings.isPaidKey: false,
          AppStrings.issueCategoryKey: _issueCategory,
          AppStrings.issueDescKey: _issueDesc,
          AppStrings.issuedByKey: userid, //TODO: make it the username/display
          AppStrings.paymentMethodKey: AppStrings.notCompletedYet,
          AppStrings.priceKey: 100, //TODO: add price to most common issues
          AppStrings.technicianRatingKey: -1,
          AppStrings.technicianReviewKey: AppStrings.notCompletedYet,
          AppStrings.timeCompletedKey: -1,
          AppStrings.timeRequestedKey: DateTime.now().millisecondsSinceEpoch,
        });
      });
      setState(() {});

      _showMyDialog();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
    }
  }

  Widget checkAppropriateGlobalHeader() {
    if (isHeaderForCategoryPageVisible) {
      return categoryPageHeader();
    } else if (isHeaderForDescPageVisible) {
      return customIssueHeader();
    } else if (isHeaderForSelectTechnicianListVisible) {
      return selectTechnicianListHeader();
    } else {
      return Container();
    }
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
                                '/dashboard or login',
                                (Route<dynamic> route) => false)
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
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TechnicianReviews()),
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

  //search function
  void searchForTechnician(String searchedValue) async {
    var techniciansRef = FirebaseFirestore.instance.collection("technicians");
    var snapshot = techniciansRef
        .where("name", isEqualTo: searchedValue)
        .limit(1)
        .get()
        .then((value) {
      value.docs.forEach((element) {

        if(element.data().containsValue(searchedValue)){
          debugPrint(element.data()["name"]);
        }
      });
    });

  }

  Widget selectTechnicianListHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              controller: searchTechnicianController,
              maxLines: 1,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: _whiteText),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: _midWhite,
                    width: 1.25,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: "Search technicians...",
                labelStyle: TextStyle(color: _whiteText),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _midWhite, width: 2.5),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: () => searchForTechnician(
                searchTechnicianController.text.toString().trim()),
            child: Icon(Icons.search),
            heroTag: 22,
          )
        ],
      ),
    );
  }

  Widget selectTechnicianOnboarding() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 90, 5, 80),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          // SafeArea(
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 16, right: 16),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: <Widget>[
          //         Text(
          //           AppStrings.selectTechnicianString,
          //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: AppStrings.techniciansList.length,
                itemBuilder: (context, index) {
                  return Visibility(
                    visible: true,
                    child: Container(
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
                            onTap: () => {setAssignedTo(index)},
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
                                          margin: EdgeInsets.fromLTRB(
                                              0, 23, 16, 16),
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                AppStrings
                                                    .techniciansList[index]
                                                    .name,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                AppStrings
                                                    .techniciansList[index]
                                                    .desc,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey.shade600,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 1,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppStrings
                                            .techniciansList[index].rating,
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
                                        margin:
                                            EdgeInsets.fromLTRB(5, 0, 16, 0),
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
                        )),
                  );
                }),
          )
        ],
      ),
    );
  }

  void setAssignedTo(int index) {
    _assignedTo = AppStrings.techniciansList[index].name;
    nextPage();
    debugPrint("Assigned to " + _assignedTo);
    setState(() => selectTechnicianValue = index);
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
    returnedList = CommonIssues.mapAllCommonIssues[_issueCategory]!;
    return returnedList;
  }

  int selectIssueValue = 134;

  Widget selectIssueTypeOnboarding(List<String> listOfIssues) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 100, 16, 80),
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
                  onTap: () => setIssueDesc(index, false, ""),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
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

  void setIssueDesc(int index, bool isCustomIssue, String customIssueTyped) {
    if(!isCustomIssue){
      List<String>? listOfRespectiveIssuesFromMap =
      CommonIssues.mapAllCommonIssues[_issueCategory];

      _issueDesc = listOfRespectiveIssuesFromMap![index];
      debugPrint("issue desc is " + _issueDesc.toString());

      nextPage();
      setState(() => selectIssueValue = index);

    } else if (isCustomIssue) {
      _issueDesc = customIssueTyped;
      setState(() => selectIssueValue = 134);
      nextPage();
    }

  }

  Widget customIssueHeader() {
    List<String>? listOfRespectiveIssuesFromMap =
        CommonIssues.mapAllCommonIssues[_issueCategory];

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: customIssueController,
              maxLines: 1,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => (listOfRespectiveIssuesFromMap!.contains(value))
                  ? "Don't type an issue that already exists in the list"
                  : null,
              style: TextStyle(color: _whiteText),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: _midWhite,
                    width: 1.25,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: _midWhite,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: "Custom issue...",
                labelStyle: TextStyle(color: _whiteText),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _midWhite, width: 2.5),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 15,),
          Container(
            width: 50,
            height: 50,
            child: FloatingActionButton(onPressed: () => {
              setIssueDesc(-1, true, customIssueController.text.toString().trim())
            },
              heroTag: AppStrings.globalHeaderHero,
            child: Icon(Icons.arrow_forward),),
          )
        ],
      ),
    );
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
  int selectCategoryValue = 14;

  void sortByApplicances() {
    selectCategoryValue = 222222;
    isSortedByTrades = false;
    setState(() => isSortedByAppliance = true);
  }

  void sortByTrades() {
    isSortedByAppliance = false;
    selectCategoryValue = 2222222;
    setState(() => isSortedByTrades = true);
  }

  // void categorySelected() {
  //   isNextButtonVisible = true;
  //   setState(() => isCategoryChosen = true);
  // }

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
              appliancesItemRow(
                CommonIssues.listOfTechnicianCategories
                    .indexOf(CommonIssues.listOfTechnicianCategories[0]),
                CommonIssues.listOfTechnicianCategories[0],
                CommonIssues.listOfTechnicianCategories
                    .indexOf(CommonIssues.listOfTechnicianCategories[1]),
                CommonIssues.listOfTechnicianCategories[1],
              ),
              appliancesItemRow(
                CommonIssues.listOfTechnicianCategories
                    .indexOf(CommonIssues.listOfTechnicianCategories[2]),
                CommonIssues.listOfTechnicianCategories[2],
                CommonIssues.listOfTechnicianCategories
                    .indexOf(CommonIssues.listOfTechnicianCategories[3]),
                CommonIssues.listOfTechnicianCategories[3],
              ),
              appliancesItemRow(
                CommonIssues.listOfTechnicianCategories
                    .indexOf(CommonIssues.listOfTechnicianCategories[4]),
                CommonIssues.listOfTechnicianCategories[4],
                CommonIssues.listOfTechnicianCategories
                    .indexOf(CommonIssues.listOfTechnicianCategories[5]),
                CommonIssues.listOfTechnicianCategories[5],
              ),
              appliancesItemRow(
                CommonIssues.listOfTechnicianCategories
                    .indexOf(CommonIssues.listOfTechnicianCategories[6]),
                CommonIssues.listOfTechnicianCategories[6],
                CommonIssues.listOfTechnicianCategories
                    .indexOf(CommonIssues.listOfTechnicianCategories[7]),
                CommonIssues.listOfTechnicianCategories[7],
              ),
              appliancesItemRow(
                CommonIssues.listOfTechnicianCategories
                    .indexOf(CommonIssues.listOfTechnicianCategories[8]),
                CommonIssues.listOfTechnicianCategories[8],
                CommonIssues.listOfTechnicianCategories
                    .indexOf(CommonIssues.listOfTechnicianCategories[9]),
                CommonIssues.listOfTechnicianCategories[9],
              ),
              tradesItemRow(
                CommonIssues.listOfAppliancesCategories
                    .indexOf(CommonIssues.listOfAppliancesCategories[0]),
                CommonIssues.listOfAppliancesCategories[0],
                CommonIssues.listOfAppliancesCategories
                    .indexOf(CommonIssues.listOfAppliancesCategories[1]),
                CommonIssues.listOfAppliancesCategories[1],
              ),
              tradesItemRow(
                CommonIssues.listOfAppliancesCategories
                    .indexOf(CommonIssues.listOfAppliancesCategories[2]),
                CommonIssues.listOfAppliancesCategories[2],
                CommonIssues.listOfAppliancesCategories
                    .indexOf(CommonIssues.listOfAppliancesCategories[3]),
                CommonIssues.listOfAppliancesCategories[3],
              ),
              tradesItemRow(
                CommonIssues.listOfAppliancesCategories
                    .indexOf(CommonIssues.listOfAppliancesCategories[4]),
                CommonIssues.listOfAppliancesCategories[4],
                CommonIssues.listOfAppliancesCategories
                    .indexOf(CommonIssues.listOfAppliancesCategories[5]),
                CommonIssues.listOfAppliancesCategories[5],
              ),
              tradesItemRow(
                CommonIssues.listOfAppliancesCategories
                    .indexOf(CommonIssues.listOfAppliancesCategories[6]),
                CommonIssues.listOfAppliancesCategories[6],
                CommonIssues.listOfAppliancesCategories
                    .indexOf(CommonIssues.listOfAppliancesCategories[7]),
                CommonIssues.listOfAppliancesCategories[7],
              ),
              tradesItemRow(
                CommonIssues.listOfAppliancesCategories
                    .indexOf(CommonIssues.listOfAppliancesCategories[8]),
                CommonIssues.listOfAppliancesCategories[8],
                CommonIssues.listOfAppliancesCategories
                    .indexOf(CommonIssues.listOfAppliancesCategories[9]),
                CommonIssues.listOfAppliancesCategories[9],
              ),
            ]));
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
              onTap: () => {
                setState(() => selectCategoryValue = selectedValueFirst),
                setIssueCategory(selectCategoryValue, false),
              },
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
              onTap: () => {
                setState(() => selectCategoryValue = selectedValueSecond),
                setIssueCategory(selectCategoryValue, false),
              },
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
              onTap: () => {
                setState(() => selectCategoryValue = selectedValueFirst),
                setIssueCategory(selectCategoryValue, true),
              },
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
              onTap: () => {
                setState(() => selectCategoryValue = selectedValueSecond),
                setIssueCategory(selectCategoryValue, true),
              },
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

  void setIssueCategory(int category, bool isSortedByTechnician) {
    if (!isSortedByTechnician) {
      setState(() =>
          _issueCategory = CommonIssues.listOfTechnicianCategories[category]);
    } else {
      setState(() =>
          _issueCategory = CommonIssues.listOfAppliancesCategories[category]);
    }
    debugPrint("Category set to $_issueCategory");

    nextPage();
  }

  Widget categoryPageHeader() {
    return Visibility(
      visible: isHeaderForCategoryPageVisible,
      child: Container(
        margin: EdgeInsets.fromLTRB(60, 40, 60, 20),
        child: Row(
          children: [
            FloatingActionButton.extended(
                heroTag: AppStrings.globalHeaderHero,
                onPressed: sortByTrades,
                label: Text("Appliances")),
            Spacer(),
            FloatingActionButton.extended(
                heroTag: 98,
                onPressed: sortByApplicances,
                label: Text("Trades"))
          ],
        ),
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

  void setEmergencyBool(bool isEmergency) {
    debugPrint("Emergency set to $isEmergency");
    _isEmergency = isEmergency;
    nextPage();
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
              onPressed: () => setEmergencyBool(true),
              label: Text(AppStrings.immediately)),
          SizedBox(height: 20),
          FloatingActionButton.extended(
              backgroundColor: Colors.blueGrey,
              heroTag: 2,
              icon: Icon(Icons.lock_clock),
              onPressed: () => setEmergencyBool(false),
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

  String _issueCategory = CommonIssues.applianceCategory9;
  String _issueDesc = " ";
  bool _isCompleted = false;
  String _assignedTo = " ";
  String _technicianRating = " ";
  String _technicianReview = " ";
  String _timeRequested = " ";
  String _timeCompleted = " ";
  String _paymentMethod = " ";
  double _price = 0.01;
  String _issueUid = " ";
  bool _isEmergency = false;
  bool _isPaid = false;
  String _issuedBy = " ";
  String _isAcceptedByTechnician = " ";
  bool isCanceledByUser = false;
  bool isDeclinedByTechnician = false;
}
