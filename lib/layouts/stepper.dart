import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technicians/layouts/login.dart';
import 'package:technicians/layouts/portfolio%20summary.dart';
import 'package:technicians/layouts/stats.dart';
import 'package:technicians/layouts/technician%20reviews.dart';

import 'package:technicians/layouts/test%20dashboard.dart';
import 'package:technicians/layouts/view%20detailed%20portfolio%20item.dart';
import 'dart:io';
import 'dart:ui';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/widgets/simple%20glass%20box.dart';

import '../models/technician object.dart';
import '../utils/strings common issues.dart';
import '../utils/strings enum.dart';
import '../widgets/glass box.dart';
import '../widgets/navigation drawer.dart';
import '../widgets/slider.dart';

class StepperProcess extends StatefulWidget {
  const StepperProcess({Key? key}) : super(key: key);

  @override
  State<StepperProcess> createState() => _StepperProcessState();
}

class _StepperProcessState extends State<StepperProcess> {
  static String _issueCategory = CommonIssues.applianceCategory9;
  bool _isCustomIssue = false;
  bool _isCompleted = false;
  String _assignedTo = " ";
  String _technicianRating = " ";
  String _technicianReview = " ";
  String _timeRequested = " ";
  String _timeCompleted = " ";
  String _paymentMethod = " ";
  double? _price = 0.01;
  String _issueUid = " ";
  bool _isEmergency = false;
  bool _isPaid = false;
  String _issuedByUid = " ";
  String _isAcceptedByTechnician = " ";
  bool _isCanceledByUser = false;
  bool _isDeclinedByTechnician = false;

  late TextEditingController customIssueController;
  TextEditingController searchTechnicianController = TextEditingController();
  String _issueDesc = " ";
  Color _whiteText = Colors.white;
  Color _midWhite = Colors.white54;

  final Color _btnColor = HexColor("#d4c4ca");
  final Color _splashClr = Colors.white;
  final Gradient _bgGradiaet = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[Colors.black, Colors.blue]);

  //TODO: get profile image and display it here
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
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
            SafeArea(
              child: Container(
                margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: ListView(
                  // shrinkWrap: true,
                  // physics: ScrollPhysics(),
                  children: [
                    IconStepper(
                      stepRadius: 20,
                      icons: const [
                        Icon(Icons.question_mark, color:Colors.white),
                        Icon(Icons.description, color:Colors.white),
                        Icon(Icons.list, color:Colors.white),
                        Icon(Icons.person, color:Colors.white),
                        Icon(Icons.upload, color:Colors.white),
                        Icon(Icons.done, color:Colors.white)
                      ],
                      enableStepTapping: true,
                      enableNextPreviousButtons: false,
                      activeStepColor: _btnColor,
                      // activeStep property set to activeStep variable defined above.
                      activeStep: activeStep,

                      // This ensures step-tapping updates the activeStep.
                      onStepReached: (index) {
                        setState(() {
                          activeStep = index;
                        });
                      },
                    ),
                    Container(
                      height: 3,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    header(),
                    Visibility(
                        visible: activeStep == 0,
                        child: categoryPageHeader(true)),
                    Visibility(
                        visible: activeStep == 0,
                        child: selectCategoryOnboarding()),
                    Visibility(
                      visible: activeStep == 1,
                      child:
                          selectIssueTypeOnboarding(selectKindOfIssuesArray()),
                    ),
                    Visibility(
                      visible: activeStep == 2,
                      child: selectTechnicianOnboarding(),
                    ),
                    Visibility(
                      visible: activeStep == 3,
                      child: assignedTechnicianProfileOnBoarding(),
                    ),
                    Visibility(
                      visible: activeStep == 4,
                      child: _showMyDialog(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 8, 0, 16),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    previousButton(),
                    nextButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return FloatingActionButton(
      splashColor: _splashClr,
      backgroundColor: activeStep == 3 ? Colors.green :
      _nextVisible ? _btnColor : Colors.grey,
      heroTag: 10,
      onPressed: _nextVisible
          ? () {
              if (activeStep < upperBound) {
                setState(() {
                  activeStep++;
                  //describe issue page
                  if (activeStep == 1) {
                    //navigating after first page
                    _prevVisible = true;
                    _nextVisible = true;
                    //technician already selected
                    if (_assignedTo != " ") {
                      _nextVisible = true;
                    }
                  }
                  //select tech page
                  if (activeStep == 2) {
                    //technician already selected
                    if (_assignedTo != " ") {
                      _nextVisible = true;
                    } else {
                      _nextVisible = false;
                    }
                  }
                });

                //tech profile page
                if(activeStep ==3) {
                  _prevVisible = true;
                }

                //Creating order page
                if(activeStep ==4) {
                  _prevVisible = false;
                  _nextVisible = false;

                }
              }
            }
          : null,
      child: Icon( activeStep == 3? Icons.upload :
        Icons.navigate_next,
        size: 35,
      ),
    );
  }

  Widget previousButton() {
    return FloatingActionButton(
      splashColor: _splashClr,
      backgroundColor: _prevVisible ? _btnColor : Colors.grey,
      heroTag: 12,
      onPressed: _prevVisible
          ? () {
              // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
              if (activeStep > 0) {
                setState(() {
                  activeStep--;
                  if (activeStep == 0) {
                    //first page so prev is invisible
                    _prevVisible = false;
                    if (isCategorySelected) {
                      //category already selected so next is visible
                      _nextVisible = true;
                    }
                  }
                  if (activeStep == 1) {
                    _nextVisible = true;
                  }
                });
              }
            }
          : null,
      child: Icon(
        Icons.navigate_before,
        size: 35,
      ),
    );
  }

// THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 0.
  bool _prevVisible = false;
  bool _nextVisible = false;
  int upperBound = 5; // upperBound MUST BE total number of icons minus 1.

  Widget header() {
    return Visibility(
      visible: false,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(width: 1, color: Colors.white),
                        color: Colors.grey.shade200.withOpacity(0.25)),
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            headerText(),
                            style: TextStyle(fontSize: 25),
                          )),
                    ),
                  ),
                ),
              ))),
    );
  }

  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Keskolede untoniua';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      default:
        return 'What do you need?';
    }
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////START DIALOGUE/////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  Widget _showMyDialog() {
    return Column(
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
            child: Text('The technician has been notified with your request')),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(40),
          child: FloatingActionButton.extended(
              //TODO: set a key here to prevent user from multiple requests
              label: Text("To dashboard"),
              onPressed: () => {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/dashboard or login', (Route<dynamic> route) => false)
                  }),
        ),
      ],
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
/////////////////////////////START PAGE 4///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  var isInOnboarding = true;

  Widget assignedTechnicianProfileOnBoarding() {
    return Stack(
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          border: Border.all(width: 3, color: Colors.white),
                          color: Colors.grey.shade200.withOpacity(0.25)),
                      // child: Center(
                      //     child: child
                      // ),
                    ),
                  ),
                ))),
        Container(
          margin: EdgeInsets.fromLTRB(20, 16, 20, 80),
          child: ListView(
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  myAssignedTech?.image == null
                      ? Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Icon(
                            Icons.person,
                            size: 120,
                            color: Colors.black12,
                          ))
                      : Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 3, color: Colors.white)),
                          child: CircleAvatar(
                            maxRadius: 60,
                            backgroundImage:
                                NetworkImage(myAssignedTech!.image!),
                            // child: Image.network(
                            //   myAssignedTech!.image!, height: 125, width: 125,),
                          ),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "${myAssignedTech?.firstName} ${myAssignedTech?.familyName}",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                )),
                            // SizedBox(width: 5,),
                            // InkWell(
                            //     onTap: () {},
                            //     child: LikeButton(
                            //       size: 40,
                            //       onTap: onLikeButtonTapped,
                            //       isLiked: listOfFavourites.contains(_issuedByUid),
                            //     )),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              myAssignedTech?.jobTitle ?? "null",
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  myAssignedTech?.location ?? "location",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  width: _statsWidth,
                                  height: _statsHeight,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(
                                          width: 2, color: _jobsBoxClr),
                                      color: Colors.grey.shade200
                                          .withOpacity(0.25)),
                                  child: Center(
                                      child: Center(
                                          child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                          alignment: Alignment.topCenter,
                                          child: Icon(Icons.handyman,
                                              color: _jobsBoxClr)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          myAssignedTech?.jobsCompleted
                                                  ?.toString() ??
                                              "0",
                                          style: TextStyle(
                                              fontSize: 30, color: _jobsBoxClr),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Jobs",
                                          style: TextStyle(
                                              color: _jobsBoxClr,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ))),
                                ),
                              ),
                            ))),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  width: _statsWidth,
                                  height: _statsHeight,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(
                                          width: 2, color: Colors.orangeAccent),
                                      color: Colors.grey.shade200
                                          .withOpacity(0.25)),
                                  child: Center(
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                            alignment: Alignment.topCenter,
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.orangeAccent,
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            myAssignedTech?.rating
                                                    ?.toString() ??
                                                "0.0",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.orangeAccent),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Rating",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    )),
                                  ),
                                ),
                              ),
                            ))),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  width: _statsWidth,
                                  height: _statsHeight,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(
                                          width: 2, color: Colors.blueAccent),
                                      color: Colors.grey.shade200
                                          .withOpacity(0.25)),
                                  child: Center(
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                            alignment: Alignment.topCenter,
                                            child: Icon(
                                              Icons.handshake,
                                              color: Colors.blueAccent,
                                            )),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            "${myAssignedTech?.completionRate?.toString()}"
                                            "%",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          //todo: Check if comp rate can be 0% when new user and use ??
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Completion",
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    )),
                                  ),
                                ),
                              ),
                            ))),
                  )
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              // onTap: () {
                              //   setState(() =>
                              //   _isDescExpanded = !_isDescExpanded);
                              //   debugPrint(
                              //       "Is desc expanded? $_isDescExpanded");
                              // },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                padding: EdgeInsets.all(12),
                                height: _isDescExpanded ? 150 : 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                    color: Colors.white.withOpacity(0.25)),
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  children: [
                                    Text(
                                      myAssignedTech?.personalDesc ??
                                          AppStrings.listOfReviews[1] +
                                              AppStrings.listOfReviews[2] +
                                              AppStrings.listOfReviews[1] +
                                              AppStrings.listOfReviews[1] +
                                              AppStrings.listOfReviews[1] +
                                              AppStrings.listOfReviews[1] +
                                              AppStrings.listOfReviews[1] +
                                              AppStrings.listOfReviews[1] +
                                              AppStrings.listOfReviews[1] +
                                              AppStrings.listOfReviews[1] +
                                              AppStrings.listOfReviews[1] +
                                              AppStrings.listOfReviews[1] +
                                              AppStrings.listOfReviews[1] +
                                              AppStrings.listOfReviews[1] +
                                              AppStrings.listOfReviews[1],
                                      maxLines: _isDescExpanded ? 8 : 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))),
              SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          onTap: () {
                            isInOnboarding = false;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PortfolioSummary(
                                        myAssignedTech!.technicianUid!)));
                          },
                          child: Container(
                            // margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.work,
                                      color: _btnColor,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Portfolio",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: _btnColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: _btnColor,
                                      child: Icon(
                                        Icons.navigate_next,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                          color: _btnColor,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: _splashClr,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TechnicianReviews(
                                      false, myAssignedTech!.technicianUid!)),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Reviews",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.navigate_next,
                                        color: _btnColor,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _isDescExpanded = false;
  double _statsHeight = 105;
  double _statsWidth = 105;
  final Color _jobsBoxClr = Colors.green;
  final Color _ratingBoxClr = Colors.orangeAccent;
  final Color _completedBoxClr = Colors.blueAccent;

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    debugPrint("===========1============");
    var ref = FirebaseFirestore.instance.collection("technicians");
    var uid = FirebaseAuth.instance.currentUser!.uid;
    debugPrint("===========2============");
    debugPrint(myAssignedTech!.technicianUid.toString());

    List listFavs = myAssignedTech!.favouritedBy!;
    debugPrint("User favs are (from like): " + listFavs.toString());
    debugPrint("===========3============");

    if (listFavs.contains(uid)) {
      listFavs.remove(uid);
      await ref.doc(myAssignedTech!.technicianUid).set({
        AppStrings.listOfFavouritedByKey: listFavs,
        AppStrings.numberOfFavouritesKey: listFavs.length,
      }, SetOptions(merge: true)).then((value) => isLiked = false);
    } else {
      listFavs.add(uid);
      await ref.doc(myAssignedTech!.technicianUid).set({
        AppStrings.listOfFavouritedByKey: listFavs,
        AppStrings.numberOfFavouritesKey: listFavs.length,
      }, SetOptions(merge: true)).then((value) => isLiked = true);
    }

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return isLiked;
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
  int selectTechnicianValue = -1;
  List<Technician> listOfAppropriateTechnicians = [];
  bool isAppliance = false;
  List listOfFavourites = [];
  Technician? myAssignedTech;
  bool? checkedIsLiked;

  //search function
  void searchForTechnician(String searchedValue) async {
    var techniciansRef = FirebaseFirestore.instance.collection("technicians");
    var snapshot = techniciansRef
        .where("name", isEqualTo: searchedValue)
        .limit(1)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data().containsValue(searchedValue)) {
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

  Future<void> getAppropriateTechnicians() async {
    listOfFavourites.clear();

    _issuedByUid = FirebaseAuth.instance.currentUser!.uid;
    listOfAppropriateTechnicians.clear();
    var technicianCollection =
        FirebaseFirestore.instance.collection("technicians");

    isAppliance =
        CommonIssues.listOfAppliancesCategories.contains(_issueCategory);
    debugPrint("issue category is $_issueCategory");

    //get list of favourites of user to pre highlight like button
    await technicianCollection
        .where(AppStrings.listOfFavouritedByKey, arrayContains: _issuedByUid)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                listOfFavourites.add(element.data()[AppStrings.technicianUid]);
              })
            });

    //looking by trades
    if (!isAppliance) {
      await technicianCollection
          .where(AppStrings.jobTitleKey, isEqualTo: _issueCategory)
          .orderBy(AppStrings.overallRatingKey, descending: true)
          .get()
          .then((value) => {
                value.docs.forEach((element) {
                  Technician i = Technician(
                    technicianUid: element.data()[AppStrings.technicianUidKey],
                    accountCreationTimeStamp:
                        element.data()[AppStrings.accountCreationTimeStampKey],
                    appliancesSubscribedTo:
                        element.data()[AppStrings.appliancesSubscribedToKey],
                    completionRate:
                        element.data()[AppStrings.completionRateKey],
                    email: element.data()[AppStrings.emailKey],
                    familyName: element.data()[AppStrings.familyNameKey],
                    favouritedBy:
                        element.data()[AppStrings.listOfFavouritedByKey],
                    image: element.data()[AppStrings.imageKey],
                    isAvailable:
                        element.data()[AppStrings.isAvailableKey], //CHECK THIS
                    isVerifiedById:
                        element.data()[AppStrings.isVerifiedByIdKey],
                    isPreferred: element.data()[AppStrings.isPreferredKey],
                    jobsCompleted: element.data()[AppStrings.jobsCompletedKey],
                    jobsDeclined: element.data()[AppStrings.jobsDeclinedKey],
                    numberOfJobsPaidPhysically:
                        element.data()[AppStrings.jobsPaidPhysicallyKey],
                    numberOfJobsPaidThroughApp:
                        element.data()[AppStrings.jobsPaidThroughAppKey],
                    numberOfJobsTerminatedMidWork:
                        element.data()[AppStrings.jobsTerminatedMidWorkKey],
                    location: element.data()[AppStrings.locationKey],
                    jobTitle: element
                        .data()[AppStrings.jobTitleKey], //NULL, ADD IT IN DB
                    pricesForJobIssues:
                        element.data()[AppStrings.mapPricesOfJobIssuesKey],
                    pricesForAppliancesSubscribedToIssues: element
                        .data()[AppStrings.mapPricesOfApplianceIssuesKey],
                    numberOfFavourites:
                        element.data()[AppStrings.numberOfFavouritesKey],
                    rating: double.parse(
                        element.data()[AppStrings.overallRatingKey].toString()),
                    phoneNumber: element.data()[AppStrings.phoneNumberKey],
                    requestAcceptanceRate:
                        element.data()[AppStrings.requestAcceptanceRateKey],
                    firstName: element.data()[AppStrings.firstNameKey],
                    personalDesc: element.data()[AppStrings.issueDescKey],
                    numberOfPortfolioItems:
                        element.data()[AppStrings.portfolioItemsKey],
                    numberOfReviews:
                        element.data()[AppStrings.numberOfReviewsKey],
                  );
                  listOfAppropriateTechnicians.add(i);
                })
              });
      debugPrint(
          "list of appropriate techs has: ${listOfAppropriateTechnicians.length}");
    }

    //looking by appliances
    else {
      await technicianCollection
          .where(AppStrings.appliancesSubscribedToKey,
              arrayContains: _issueCategory)
          .orderBy(AppStrings.overallRatingKey, descending: true)
          .get()
          .then((value) => {
                value.docs.forEach((element) {
                  Technician i = Technician(
                    technicianUid: element.data()[AppStrings.technicianUidKey],
                    accountCreationTimeStamp:
                        element.data()[AppStrings.accountCreationTimeStampKey],
                    appliancesSubscribedTo:
                        element.data()[AppStrings.appliancesSubscribedToKey],
                    completionRate:
                        element.data()[AppStrings.completionRateKey],
                    email: element.data()[AppStrings.emailKey],
                    familyName: element.data()[AppStrings.familyNameKey],
                    favouritedBy:
                        element.data()[AppStrings.listOfFavouritedByKey],
                    image: element.data()[AppStrings.imageKey],
                    isAvailable:
                        element.data()[AppStrings.isAvailableKey], //CHECK THIS
                    isVerifiedById:
                        element.data()[AppStrings.isVerifiedByIdKey],
                    isPreferred: element.data()[AppStrings.isPreferredKey],
                    jobsCompleted: element.data()[AppStrings.jobsCompletedKey],
                    jobsDeclined: element.data()[AppStrings.jobsDeclinedKey],
                    numberOfJobsPaidPhysically:
                        element.data()[AppStrings.jobsPaidPhysicallyKey],
                    numberOfJobsPaidThroughApp:
                        element.data()[AppStrings.jobsPaidThroughAppKey],
                    numberOfJobsTerminatedMidWork:
                        element.data()[AppStrings.jobsTerminatedMidWorkKey],
                    location: element.data()[AppStrings.locationKey],
                    jobTitle: element
                        .data()[AppStrings.jobTitleKey], //NULL, ADD IT IN DB
                    pricesForJobIssues:
                        element.data()[AppStrings.mapPricesOfJobIssuesKey],
                    pricesForAppliancesSubscribedToIssues: element
                        .data()[AppStrings.mapPricesOfApplianceIssuesKey],
                    numberOfFavourites:
                        element.data()[AppStrings.numberOfFavouritesKey],
                    rating: double.parse(
                        element.data()[AppStrings.overallRatingKey].toString()),
                    phoneNumber: element.data()[AppStrings.phoneNumberKey],
                    requestAcceptanceRate:
                        element.data()[AppStrings.requestAcceptanceRateKey],
                    firstName: element.data()[AppStrings.firstNameKey],
                    personalDesc: element.data()[AppStrings.issueDescKey],
                    numberOfPortfolioItems:
                        element.data()[AppStrings.portfolioItemsKey],
                    numberOfReviews:
                        element.data()[AppStrings.numberOfReviewsKey],
                  );
                  listOfAppropriateTechnicians.add(i);
                })
              });
      debugPrint(
          "list of appropriate techs has: ${listOfAppropriateTechnicians.length}");
    }
  }

  Widget selectTechnicianOnboarding() {
    return FutureBuilder(
        future: getAppropriateTechnicians(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            listOfAppropriateTechnicians.toSet().toList();
            debugPrint(
                "Filtered list of appropriate techs to: ${listOfAppropriateTechnicians.length}");
            return Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 80),
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height - 190,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: listOfAppropriateTechnicians.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: listOfAppropriateTechnicians.length,
                            itemBuilder: (context, index) {
                              return Visibility(
                                  visible: !isAppliance
                                      ? true
                                      : listOfAppropriateTechnicians[index]
                                                  .pricesForAppliancesSubscribedToIssues![
                                              _issueDesc] !=
                                          null,
                                  child: Container(
                                    height: 100,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 4),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10.0, sigmaY: 10.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 90,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30)),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.white),
                                                color: Colors.grey.shade200
                                                    .withOpacity(0.25)),
                                            child: InkWell(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              splashColor: _splashClr,
                                              onTap: () =>
                                                  {setAssignedTo(index)},
                                              child: AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 200),
                                                decoration: BoxDecoration(
                                                    color:
                                                        selectTechnicianValue ==
                                                                index
                                                            ? _btnColor
                                                            : Colors
                                                                .transparent,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30))),
                                                child: Row(children: <Widget>[
                                                  Expanded(
                                                    child: Row(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 16, 0, 16),
                                                          child: Stack(
                                                              children: [
                                                                listOfAppropriateTechnicians[index]
                                                                            .image ==
                                                                        null
                                                                    ? Container(
                                                                        decoration: BoxDecoration(
                                                                            shape: BoxShape
                                                                                .circle,
                                                                            color: Colors
                                                                                .white),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .person,
                                                                          size:
                                                                              57.5,
                                                                          color:
                                                                              Colors.black12,
                                                                        ))
                                                                    : Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            border: Border.all(width: 2, color: Colors.white)),
                                                                        child:
                                                                            CircleAvatar(
                                                                          maxRadius:
                                                                              28.5,
                                                                          backgroundImage:
                                                                              NetworkImage(listOfAppropriateTechnicians[index].image!),
                                                                          // child: Image.network(
                                                                          //   myAssignedTech!.image!, height: 125, width: 125,),
                                                                        ),
                                                                      ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomCenter,
                                                                  child:
                                                                      Visibility(
                                                                    visible: listOfAppropriateTechnicians[
                                                                            index]
                                                                        .isAvailable!,
                                                                    child: CircleAvatar(
                                                                        maxRadius:
                                                                            7,
                                                                        backgroundColor:
                                                                            Colors.green),
                                                                  ),
                                                                )
                                                              ]),
                                                        ),
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 23,
                                                                    16, 16),
                                                            color: Colors
                                                                .transparent,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      listOfAppropriateTechnicians[index]
                                                                              .firstName ??
                                                                          "null",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      listOfAppropriateTechnicians[index]
                                                                              .familyName ??
                                                                          "null",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 6,
                                                                ),
                                                                Text(
                                                                  listOfAppropriateTechnicians[
                                                                              index]
                                                                          .jobTitle ??
                                                                      "null",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade600,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  maxLines: 1,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(16, 16,
                                                                  0, 16),
                                                          child: Column(
                                                            children: [
                                                              //price commented out
                                                              // Visibility(
                                                              //   visible:
                                                              //       !_isCustomIssue,
                                                              //   child: Align(
                                                              //     alignment:
                                                              //         Alignment
                                                              //             .topLeft,
                                                              //     child: Text(
                                                              //       isAppliance
                                                              //           ? listOfAppropriateTechnicians[index].pricesForAppliancesSubscribedToIssues![_issueDesc].toString() +
                                                              //               "\$"
                                                              //           : listOfAppropriateTechnicians[index].pricesForJobIssues![_issueDesc].toString() +
                                                              //               "\$",
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          5,
                                                                          10,
                                                                          0),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            listOfAppropriateTechnicians[index].rating.toString(),
                                                                            style:
                                                                                TextStyle(fontSize: 16, fontWeight: listOfAppropriateTechnicians[index].isAvailable! ? FontWeight.bold : FontWeight.normal),
                                                                          ),
                                                                          Container(
                                                                            margin: EdgeInsets.fromLTRB(
                                                                                5,
                                                                                0,
                                                                                16,
                                                                                0),
                                                                            child: Icon(Icons.star,
                                                                                size: 16,
                                                                                color: Colors.orangeAccent
                                                                                // HexColor(
                                                                                //     "FFD700"),
                                                                                ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              7),
                                                                      Align(
                                                                          alignment: Alignment
                                                                              .bottomCenter,
                                                                          child:
                                                                              Text(listOfAppropriateTechnicians[index].location ?? "")),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            })
                        : Center(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Image.asset(
                                    "assets/no result.png",
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "No technicians, please try another issue.",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ),
                  )
                ],
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 125,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Lottie.asset('assets/loading.json',
                    height: 75,
                    width: 75,
                    alignment: Alignment.center,
                    animate: true),
              ),
            );
          }
        });
  }

  void setAssignedTo(int index) {
    myAssignedTech = listOfAppropriateTechnicians[index];
    _assignedTo = listOfAppropriateTechnicians[index].firstName! +
        " " +
        listOfAppropriateTechnicians[index].familyName!;
    _nextVisible = true;
    if (isAppliance) {
      _price = listOfAppropriateTechnicians[index]
          .pricesForAppliancesSubscribedToIssues![_issueCategory];
    } else if (!isAppliance) {
      _price = listOfAppropriateTechnicians[index]
          .pricesForJobIssues![_issueCategory];
    }
    if (_isCustomIssue) {
      _price = -1;
    }
    debugPrint("Assigned to " + _assignedTo);
    setState(() {
      activeStep++;
      selectTechnicianValue = index;
    });
  }

  ////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////END PAGE 3/////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/////////////////////////////START PAGE 2///////////////////////////////////////
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
    return Stack(
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          border: Border.all(width: 3, color: Colors.white),
                          color: Colors.grey.shade200.withOpacity(0.25)),
                    ),
                  ),
                ))),
        Container(
          margin: EdgeInsets.fromLTRB(30, 25, 30, 15),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 16, 10, 10),
                child: Text(
                  "Describe your issue",
                  style: TextStyle(fontSize: 25, color: Colors.black54),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                focusNode: firstFocusNode,
                controller: customIssueController,
                maxLines: 5,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // validator: (value) => (listOfRespectiveIssuesFromMap!
                //     .contains(value))
                //     ? "Don't type an issue that already exists in the list"
                //     : null,
                style: TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                  fillColor: Colors.white54,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white54,
                      width: 1.25,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: "What is the issue...",
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(color: Colors.black54),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.5),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Center(
                  child: Text(
                    "OR",
                    style: TextStyle(fontSize: 25, color: Colors.black54),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FloatingActionButton.extended(
                  splashColor: _splashClr,
                  heroTag: 2132,
                  onPressed: () {
                    _isCustomIssue = false;
                    //TODO: make dialog show "no common issues" if none exist
                    showCustomDialog(context, listOfIssues);
                  },
                  backgroundColor: _btnColor,
                  label: Text("Choose a common issue"),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                height: 3,
                color: Colors.white,
                width: double.infinity,
              ),
              SizedBox(
                width: double.infinity,
                child: FloatingActionButton.extended(
                  splashColor: _splashClr,
                  heroTag: 2132,
                  onPressed: () {
                    selectMultipleImages();
                  },
                  backgroundColor: _btnColor,
                  icon: Icon(Icons.photo),
                  label: Text("Add Images"),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: files?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Image.file(
                        File(files![index].path),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              // Container(
              //   width: 50,
              //   height: 50,
              //   child: FloatingActionButton(
              //     onPressed: () => {
              //       setIssueDesc(
              //           -1, true, customIssueController.text.toString().trim())
              //     },
              //     heroTag: AppStrings.globalHeaderHero,
              //     child: Icon(Icons.arrow_forward),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  void showCustomDialog(BuildContext context, List listOfIssues) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: listOfIssues.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        setIssueDesc(index, false, "");
                        _isCustomIssue = false;
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: selectIssueValue == index
                              ? Colors.greenAccent
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
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  void setIssueDesc(int index, bool isCustomIssue, String customIssueTyped) {
    if (!isCustomIssue) {
      List<String>? listOfRespectiveIssuesFromMap =
          CommonIssues.mapAllCommonIssues[_issueCategory];
      _issueDesc = listOfRespectiveIssuesFromMap![index];
      debugPrint("issue desc is " + _issueDesc.toString());

      customIssueController.text = _issueDesc;
      setState(() => selectIssueValue = index);
      Navigator.pop(context);
    } else if (isCustomIssue) {
      _isCustomIssue = isCustomIssue;
      _issueDesc = customIssueTyped;
      setState(() => selectIssueValue = 134);
      Navigator.pop(context);
    }
  }

  FocusNode firstFocusNode = FocusNode();
  var isDontSeeYourIssue = false;

  File _imageFile = File("");
  final picker = ImagePicker();
  List<File>? files;
  UploadTask? uploadTask;
  List<String> listOfFilePaths = [];

  Future uploadImageToFirebase(dynamic listOfFiles) async {
    try {
      Fluttertoast.showToast(msg: "Uploading attached images...");
      // Create a Reference to the file
      var currentTime = DateTime.now().millisecondsSinceEpoch;
      for (int i = 0; i < files!.length; i++) {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('issues')
            .child("/issues by user: ${FirebaseAuth.instance.currentUser!.uid}")
            .child("/$_issueDesc on $currentTime")
            .child(_imageFile.path);

        uploadTask = ref.putFile(listOfFiles[i]);

        final snapShot = await uploadTask!.whenComplete(() => {});
        final urlDownload = await snapShot.ref.getDownloadURL();
        listOfFilePaths.add(urlDownload);

        uploadTask = null;
      }
      Fluttertoast.showToast(
          msg: "Finished Uploading", backgroundColor: Colors.green);
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
          msg: "Failed to upload images", backgroundColor: Colors.redAccent);
    }
  }

  Future selectMultipleImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'svg']);

    if (result != null) {
      setState(
          () => {files = result.paths.map((path) => File(path!)).toList()});
    } else {
      // User canceled the picker
    }
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

  int selectCategoryValue = 14;
  bool isCategorySelected = false;

  void sortByApplicances() {
    selectCategoryValue = 222222;
    _isSortedByTrades = false;
    setState(() => _isSortedByAppliance = true);
  }

  void sortByTrades() {
    selectCategoryValue = 2222222;
    _isSortedByAppliance = false;
    setState(() => _isSortedByTrades = true);
  }

  // void categorySelected() {
  //   isNextButtonVisible = true;
  //   setState(() => isCategoryChosen = true);
  // }

  Widget selectCategoryOnboarding() {
    return Container(
        margin: EdgeInsets.fromLTRB(8, 0, 8, 16),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            if (_isSortedByTrades) {
              return techsList(index);
            } else {
              return appliancesList(index);
            }
          },
        ));
  }

  Widget techsList(int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: _splashClr,
        highlightColor: Colors.white,
        onTap: () {
          isCategorySelected = true;
          _nextVisible = true;
          setState(() => selectCategoryValue = index);
          setIssueCategory(selectCategoryValue, true);
        },
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: AnimatedContainer(
            decoration: BoxDecoration(
              color:
                  selectCategoryValue == index ? _btnColor : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            duration: Duration(milliseconds: 400),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          border: Border.all(width: 2, color: Colors.white),
                          color: Colors.grey.shade200.withOpacity(0.25)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Image.asset(
                              selectCategoryValue == index
                                  ? CommonIssues.listOfSelectedTechImages[index]
                                  : CommonIssues
                                      .listOfNotSelectedTechImages[index],
                              height: 75,
                              width: 75,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Text(CommonIssues
                                  .listOfTechnicianCategories[index]))
                        ],
                      ),
                    ),
                  ),
                ))),
      ),
    );
  }

  Widget appliancesList(int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: _splashClr,
        highlightColor: Colors.white,
        onTap: () {
          isCategorySelected = true;
          _nextVisible = true;
          setState(() => selectCategoryValue = index);
          setIssueCategory(selectCategoryValue, false);
        },
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: AnimatedContainer(
            decoration: BoxDecoration(
              color: selectCategoryValue == index
                  ? Colors.greenAccent
                  : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            duration: Duration(milliseconds: 400),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          border: Border.all(width: 2, color: Colors.white),
                          color: Colors.grey.shade200.withOpacity(0.25)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Image.asset(
                              selectCategoryValue == index
                                  ? CommonIssues
                                      .listOfSelectedApplianceImages[index]
                                  : CommonIssues
                                      .listOfNotSelectedApplianceImages[index],
                              height: 75,
                              width: 75,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: _isSortedByTrades
                                  ? Text(CommonIssues
                                      .listOfTechnicianCategories[index])
                                  : Text(CommonIssues
                                      .listOfAppliancesCategories[index]))
                        ],
                      ),
                    ),
                  ),
                ))),
      ),
    );
  }

  bool _isIssueDescribed = false;

  @override
  void dispose() {
    firstFocusNode.removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    customIssueController = TextEditingController();
    firstFocusNode.addListener(() {
      // if(!firstFocusNode.hasFocus){
      //   if(customIssueController.text.trim().toString().isEmpty){
      //     _isIssueDescribed = false;
      //     Fluttertoast.showToast(msg: "Empty issue");
      //   } else {
      //     _isIssueDescribed = false;
      //     Fluttertoast.showToast(msg: "Issue made");
      //   }
      // }
    });
    super.initState();
  }

  Widget categoryPageHeader(bool visible) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 8, 0, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2,
                    color: _isSortedByTrades ? Colors.blue : Colors.grey)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                onTap: () {
                  sortByTrades;
                  setState(() {
                    _isSortedByAppliance = false;
                    _isSortedByTrades = true;
                  });
                },
                child: Image.asset(
                  _isSortedByTrades
                      ? "assets/human selected.png"
                      : "assets/human not selected.png",
                  height: 60,
                  width: 60,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2,
                    color: _isSortedByAppliance ? Colors.blue : Colors.grey)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                onTap: () {
                  sortByApplicances();
                  setState(() {
                    _isSortedByAppliance = true;
                    _isSortedByTrades = false;
                  });
                },
                child: Image.asset(
                  _isSortedByAppliance
                      ? "assets/machine selected.png"
                      : "assets/machine not selected.png",
                  height: 60,
                  width: 60,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  var _isSortedByAppliance = false;
  var _isSortedByTrades = true;

  void setIssueCategory(int category, bool isSortedByTechnician) {
    if (isSortedByTechnician) {
      setState(() =>
          _issueCategory = CommonIssues.listOfTechnicianCategories[category]);
    } else {
      setState(() =>
          _issueCategory = CommonIssues.listOfAppliancesCategories[category]);
    }
    debugPrint("Category set to $_issueCategory");
  }
}
