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

class TestUI extends StatefulWidget {
  const TestUI({Key? key}) : super(key: key);

  @override
  State<TestUI> createState() => _TestUIState();
}

class _TestUIState extends State<TestUI> {
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
  var _isSortedByAppliance = true;
  var _isSortedByTrades = false;
  TextEditingController customIssueController = TextEditingController();
  TextEditingController searchTechnicianController = TextEditingController();
  String _issueDesc = " ";
  Color _whiteText = Colors.white;
  Color _midWhite = Colors.white54;

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
            Container(
              margin: EdgeInsets.fromLTRB(8, 0, 8, 16),
              child: ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  IconStepper(
                    stepRadius: 20,
                    icons: const [
                      Icon(Icons.question_mark),
                      Icon(Icons.description),
                      Icon(Icons.list),
                      Icon(Icons.person),
                      Icon(Icons.done)
                    ],
                    enableStepTapping: false,
                    enableNextPreviousButtons: false,

                    // activeStep property set to activeStep variable defined above.
                    activeStep: activeStep,

                    // This ensures step-tapping updates the activeStep.
                    onStepReached: (index) {
                      setState(() {
                        activeStep = index;
                      });
                    },
                  ),
                  header(),
                  Visibility(
                      visible: activeStep == 0,
                      child: selectCategoryOnboarding()),
                  Visibility(
                    visible: activeStep == 1,
                    child: selectIssueTypeOnboarding(selectKindOfIssuesArray()),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      previousButton(),
                      nextButton(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return FloatingActionButton(
      heroTag: 10,
      onPressed: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => TestDashboard()));

        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: Icon(Icons.navigate_next),
    );
  }

  Widget previousButton() {
    return FloatingActionButton(
      heroTag: 12,
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Icon(Icons.navigate_before),
    );
  }

// THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 0.

  int upperBound = 4; // upperBound MUST BE total number of icons minus 1.

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      default:
        return 'Introduction';
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
    return
      Column(
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
    return Container(
      margin: EdgeInsets.fromLTRB(20, 16, 20, 80),
      child: ListView(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true, // use this
        children: [
          Container(
              child: Icon( //TODO: CHANGE THIS TO TECH IMAGE
                Icons.person,
                size: 75,
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
                        "${myAssignedTech?.firstName} ${myAssignedTech?.familyName}",
                        maxLines: 1,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: 5),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        myAssignedTech?.jobTitle  ?? "null",
                        maxLines: 1,
                        style: TextStyle(fontSize: 18, ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "a short desc", //TODO: add in db
                        maxLines: 2,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: false,
                    child: InkWell(onTap: () {},
                        child: LikeButton(
                          onTap: onLikeButtonTapped,
                          isLiked: listOfFavourites.contains(_issuedByUid) ,
                          // isLiked: (myAssignedTech!.favouritedBy!.contains(_issuedByUid)) ?
                          // true : false,
                          // isLiked: myAssignedTech!.favouritedBy!.contains(_issuedByUid),
                        )),
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
                                        TechnicianReviews(false, myAssignedTech!.technicianUid!)),
                              )
                            }),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton.extended(
                              heroTag: 2,
                              label: Text("portfolio"),
                              onPressed: () {
                                isInOnboarding = false;
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => PortfolioSummary(myAssignedTech!.technicianUid!)));
                              })),
                    ],
                  ),
                ],
              ),
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
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              myAssignedTech?.jobsCompleted?.toString() ?? "-1",
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
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              myAssignedTech?.rating?.toString() ?? "-1",
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
                        children:  [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "${myAssignedTech?.completionRate?.toString()}" "%",
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

  Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// send your request here
    debugPrint("===========1============");
    var ref = FirebaseFirestore.instance.collection("technicians");
    var uid = FirebaseAuth.instance.currentUser!.uid;
    debugPrint("===========2============");
    debugPrint(myAssignedTech!.technicianUid.toString());

    List listFavs = myAssignedTech!.favouritedBy!;
    debugPrint("User favs are (from like): " + listFavs.toString());
    debugPrint("===========3============");

    if(listFavs.contains(uid)){

      listFavs.remove(uid);
      await ref.doc(myAssignedTech!.technicianUid).set({
        AppStrings.listOfFavouritedByKey : listFavs ,
        AppStrings.numberOfFavouritesKey : listFavs.length,
      }, SetOptions(merge: true)).then((value) => isLiked = false);
    } else {

      listFavs.add(uid);
      await ref.doc(myAssignedTech!.technicianUid).set({
        AppStrings.listOfFavouritedByKey : listFavs ,
        AppStrings.numberOfFavouritesKey : listFavs.length,
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
                physics: ScrollPhysics(),
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
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: InkWell(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    splashColor: Colors.redAccent,
                                    onTap: () => {setAssignedTo(index)},
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      decoration: BoxDecoration(
                                          color: selectTechnicianValue == index
                                              ? Colors.redAccent
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Row(children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 16, 0, 16),
                                                child: Stack(children: [
                                                  CircleAvatar(
                                                    // backgroundImage:
                                                    // AppStrings.techniciansList[index].image,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    maxRadius: 30,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Visibility(
                                                      visible:
                                                          listOfAppropriateTechnicians[
                                                                  index]
                                                              .isAvailable!,
                                                      child: CircleAvatar(
                                                          maxRadius: 7,
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
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 23, 16, 16),
                                                  color: Colors.transparent,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        listOfAppropriateTechnicians[
                                                                    index]
                                                                .firstName ??
                                                            "null",
                                                        style: TextStyle(
                                                            fontSize: 16),
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
                                                            fontSize: 13,
                                                            color: Colors
                                                                .grey.shade600,
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
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 16, 0, 16),
                                                child: Column(
                                                  children: [
                                                    Visibility(
                                                      visible: !_isCustomIssue,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          isAppliance
                                                              ? listOfAppropriateTechnicians[
                                                                          index]
                                                                      .pricesForAppliancesSubscribedToIssues![
                                                                          _issueDesc]
                                                                      .toString() +
                                                                  "\$"
                                                              : listOfAppropriateTechnicians[
                                                                          index]
                                                                      .pricesForJobIssues![
                                                                          _issueDesc]
                                                                      .toString() +
                                                                  "\$",
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 5, 0, 0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            listOfAppropriateTechnicians[
                                                                    index]
                                                                .rating
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: listOfAppropriateTechnicians[
                                                                            index]
                                                                        .isAvailable!
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .normal),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(5, 0,
                                                                    16, 0),
                                                            child: Icon(
                                                              Icons.star,
                                                              size: 16,
                                                              color: HexColor(
                                                                  "FFD700"),
                                                            ),
                                                          ),
                                                        ],
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
                                )),
                          );
                        }),
                  )
                ],
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
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
    setState(() => selectTechnicianValue = index);
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
  bool _visible = true;

  Widget selectIssueTypeOnboarding(List<String> listOfIssues) {
    return Visibility(
      visible: true,
      child: Column(
        children: [
          customIssueHeader(),
          Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: listOfIssues.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
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
          ),
        ],
      ),
    );
  }

  void setIssueDesc(int index, bool isCustomIssue, String customIssueTyped) {
    if (!isCustomIssue) {
      List<String>? listOfRespectiveIssuesFromMap =
          CommonIssues.mapAllCommonIssues[_issueCategory];

      _issueDesc = listOfRespectiveIssuesFromMap![index];
      debugPrint("issue desc is " + _issueDesc.toString());
      setState(() => selectIssueValue = index);
    } else if (isCustomIssue) {
      _isCustomIssue = isCustomIssue;
      _issueDesc = customIssueTyped;
      setState(() => selectIssueValue = 134);
    }
  }

  var isDontSeeYourIssue = false;

  File _imageFile = File("");
  final picker = ImagePicker();
  List<File>? files;
  UploadTask? uploadTask;
  List<String> listOfFilePaths = [];

  Widget customIssueHeader() {
    List<String>? listOfRespectiveIssuesFromMap =
        CommonIssues.mapAllCommonIssues[_issueCategory];

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CheckboxListTile(
            title: Text("Don't see your issue?"),
            value: isDontSeeYourIssue,
            checkboxShape: CircleBorder(),
            onChanged: (value) {
              selectIssueValue = 135;
              setState(() {
                isDontSeeYourIssue = value!;
              });
            },
          ),
          Visibility(
            visible: isDontSeeYourIssue,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: customIssueController,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => (listOfRespectiveIssuesFromMap!
                            .contains(value))
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
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    onPressed: () => {
                      setIssueDesc(-1, true,
                          customIssueController.text.toString().trim())
                    },
                    heroTag: AppStrings.globalHeaderHero,
                    child: Icon(Icons.arrow_forward),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: selectMultipleImages, child: Text("Add pictures")),
              Text(files == null
                  ? "No Images added"
                  : "Added ${files!.length} images"),
              TextButton(
                child: Text("Click to see"),
                onPressed: () {
                  Fluttertoast.cancel();
                  if (files == null) {
                    Fluttertoast.showToast(
                      msg: "No images selected",
                    );
                    return;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewDetailedPortfolioItem(
                              files, 12345, _issueDesc, true)));
                },
              )
            ],
          ),
        ],
      ),
    );
  }

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

  void sortByApplicances() {
    selectCategoryValue = 222222;
    _isSortedByTrades = false;
    setState(() => _isSortedByAppliance = true);
  }

  void sortByTrades() {
    _isSortedByAppliance = false;
    selectCategoryValue = 2222222;
    setState(() => _isSortedByTrades = true);
  }

  // void categorySelected() {
  //   isNextButtonVisible = true;
  //   setState(() => isCategoryChosen = true);
  // }

  Widget selectCategoryOnboarding() {
    return Container(
        margin: EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              categoryPageHeader(true),
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
      visible: _isSortedByAppliance,
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
      visible: _isSortedByTrades,
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

  Widget categoryPageHeader(bool visible) {
    return Visibility(
      visible: visible,
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

  void setIssueCategory(int category, bool isSortedByTechnician) {
    if (!isSortedByTechnician) {
      setState(() =>
          _issueCategory = CommonIssues.listOfTechnicianCategories[category]);
    } else {
      setState(() =>
          _issueCategory = CommonIssues.listOfAppliancesCategories[category]);
    }
    debugPrint("Category set to $_issueCategory");
  }
}
