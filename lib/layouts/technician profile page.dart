import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:technicians/layouts/portfolio%20summary.dart';
import 'package:technicians/layouts/stepper.dart';
import 'package:technicians/layouts/technician%20reviews.dart';
import 'package:technicians/models/technician%20object.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'package:technicians/widgets/glass%20box.dart';
import 'package:technicians/widgets/navigation%20drawer.dart';
import 'package:technicians/widgets/slider.dart';

import '../utils/hex colors.dart';

class TechnicianMainProfilePage extends StatefulWidget {
  final String selectedTechnicianUid;
  const TechnicianMainProfilePage(this.selectedTechnicianUid, {Key? key})
      : super(key: key);

  @override
  State<TechnicianMainProfilePage> createState() =>
      _TechnicianMainProfilePageState();
}

class _TechnicianMainProfilePageState extends State<TechnicianMainProfilePage>
    with TickerProviderStateMixin {
  Technician? selectedTechnician;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      // appBar: AppBar(
      //   elevation: 0.0,
      //   title: Text("widget.title"),
      // ),
      body: assignedTechnicianProfileOnBoarding(),
    );
  }

  Future<void> getSelectedTechnician() async {

    var technicianCollection =
        FirebaseFirestore.instance.collection("technicians");

    //looking by trades
    await technicianCollection
        .where(AppStrings.technicianUidKey,
            isEqualTo: widget.selectedTechnicianUid)
        .get()
        .then((value) async => {
              value.docs.forEach((element) {
                selectedTechnician = Technician(
                  technicianUid: element.data()[AppStrings.technicianUidKey],
                  accountCreationTimeStamp:
                      element.data()[AppStrings.accountCreationTimeStampKey],
                  appliancesSubscribedTo:
                      element.data()[AppStrings.appliancesSubscribedToKey],
                  completionRate: element.data()[AppStrings.completionRateKey],
                  email: element.data()[AppStrings.emailKey],
                  familyName: element.data()[AppStrings.familyNameKey],
                  favouritedBy:
                      element.data()[AppStrings.listOfFavouritedByKey],
                  image: element.data()[AppStrings.imageKey],
                  isAvailable:
                      element.data()[AppStrings.isAvailableKey], //CHECK THIS
                  isVerifiedById: element.data()[AppStrings.isVerifiedByIdKey],
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
                  pricesForAppliancesSubscribedToIssues:
                      element.data()[AppStrings.mapPricesOfApplianceIssuesKey],
                  numberOfFavourites:
                      element.data()[AppStrings.numberOfFavouritesKey],
                  rating: double.parse(
                      element.data()[AppStrings.overallRatingKey].toString()),
                  phoneNumber: element.data()[AppStrings.phoneNumberKey],
                  requestAcceptanceRate:
                      element.data()[AppStrings.requestAcceptanceRateKey],
                  firstName: element.data()[AppStrings.firstNameKey],
                  techDesc: element.data()[AppStrings.technicianDesc],
                  numberOfPortfolioItems:
                      element.data()[AppStrings.portfolioItemsKey],
                  numberOfReviews:
                      element.data()[AppStrings.numberOfReviewsKey],
                );
                _isLiked = selectedTechnician!.favouritedBy!
                    .contains(FirebaseAuth.instance.currentUser!.uid);
                debugPrint("Tech is liked: $_isLiked");
              })
            });
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "No internet connection", backgroundColor: Colors.red);
      return isLiked;
    }

    /// send your request here
    var ref = FirebaseFirestore.instance.collection("technicians");
    var uid = FirebaseAuth.instance.currentUser!.uid;
    List listFavs = selectedTechnician!.favouritedBy!;

    if (listFavs.contains(uid)) {
      listFavs.remove(uid);
      await ref.doc(selectedTechnician!.technicianUid).set({
        AppStrings.listOfFavouritedByKey: listFavs,
        AppStrings.numberOfFavouritesKey: listFavs.length,
      }, SetOptions(merge: true)).then((value) => isLiked = false);
    } else {
      listFavs.add(uid);
      await ref.doc(selectedTechnician!.technicianUid).set({
        AppStrings.listOfFavouritedByKey: listFavs,
        AppStrings.numberOfFavouritesKey: listFavs.length,
      }, SetOptions(merge: true)).then((value) => isLiked = true);
    }
    debugPrint("Like status is: $_isLiked");

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return isLiked;
  }

  bool? _isLiked = false;
  Animation<double>? animation;
  AnimationController? _lottieAnimationController;
  Tween<double> tween = Tween(begin: 0, end: 100);
  late Future<void> getTechDate;

  @override
  void initState() {
    _lottieAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _lottieAnimationController?.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);

        Future.delayed(Duration(milliseconds: 300), () {
          _lottieAnimationController?.reset();
        });
      }
    });
    // animation = tween.animate(_lottieAnimationController!);

    getTechDate = getSelectedTechnician();
    super.initState();
  }

  Widget assignedTechnicianProfileOnBoarding() {
    return Stack(
      children: [
        Image.asset(
          "assets/abstract bg.jpg",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        FutureBuilder(
            future: getTechDate,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [

                    //=======the background glass rectangle=======
                    Container(
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
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(
                                          width: 3, color: Colors.white),
                                      color: Colors.grey.shade200
                                          .withOpacity(0.25)),
                                  // child: Center(
                                  //     child: child
                                  // ),
                                ),
                              ),
                            ))),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 16, 20, 24),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          Row(
                            children: [

                              //=======profile pic=======
                              selectedTechnician?.image == null
                                  ? Container(
                                      margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
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
                                          border: Border.all(
                                              width: 3, color: Colors.white)),
                                      child: CircleAvatar(
                                        maxRadius: 60,
                                        backgroundImage: NetworkImage(
                                            selectedTechnician!.image!),
                                      ),
                                    ),
                              SizedBox(
                                width: 10,
                              ),

                              //=======name=======
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(

                                          child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "${selectedTechnician?.firstName} ${selectedTechnician?.familyName}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),

                                    //=======job title=======
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          selectedTechnician?.jobTitle ??
                                              "null",
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),

                                    //=======location=======
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_rounded,
                                              color: Colors.red[900],
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              selectedTechnician?.location ??
                                                  "location",
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(height: 15,),

                                    //======like======
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: FloatingActionButton.extended(
                                                onPressed: () {
                                                  _isLiked = !_isLiked!;
                                                  onLikeButtonTapped(_isLiked!);
                                                  setState(() => _isLiked = _isLiked);
                                                },
                                            label: Text("اعجاب", style: TextStyle(color: _isLiked! ? Colors.red[800] : _darkTxtClr),),
                                                icon: Icon(
                                            Icons.favorite,
                                            color:  _isLiked! ? Colors.red[800] : _darkTxtClr,
                                          ),
                                            heroTag: "12",
                                            backgroundColor: Colors.white,
                                              ),
                                        ),
                                        SizedBox(width: 10,),

                                        //======hire me=======
                                        Flexible(
                                          flex:1,
                                          child: FloatingActionButton.extended(
                                            onPressed: () {
                                              debugPrint("${selectedTechnician!.firstName!} is first name");
                                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                              StepperProcess(hiredSpecificTech: selectedTechnician!)));
                                            },
                                            label: Text("وظفني",style: TextStyle(color: _darkTxtClr),),
                                            heroTag: "1",
                                            icon: Icon(
                                              Icons.business_center,
                                              color: _darkTxtClr,
                                            ),
                                            backgroundColor: Colors.white,

                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              //=======jobs completed box=======
                              Expanded(
                                flex: 1,
                                child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Align(
                                        alignment: Alignment.topCenter,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10.0, sigmaY: 10.0),
                                            child: Material(
                                              color: Colors.white54,
                                              child: Container(
                                                width: _statsWidth,
                                                height: _statsHeight,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: _jobsBoxClr),
                                                    color: Colors.grey.shade200
                                                        .withOpacity(0.25)),
                                                child: Center(
                                                    child: Center(
                                                        child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Icon(
                                                            Icons.handyman,
                                                            color:
                                                                _jobsBoxClr)),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Text(
                                                        selectedTechnician
                                                                ?.jobsCompleted
                                                                ?.toString() ??
                                                            "0",
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: _jobsBoxClr),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Jobs",
                                                        style: TextStyle(
                                                            color: _jobsBoxClr,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )
                                                  ],
                                                ))),
                                              ),
                                            ),
                                          ),
                                        ))),
                              ),

                              //=======rating box=======
                              Expanded(
                                flex: 1,
                                child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Align(
                                        alignment: Alignment.topCenter,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10.0, sigmaY: 10.0),
                                            child: Material(
                                              color: Colors.white54,
                                              child: Container(
                                                width: _statsWidth,
                                                height: _statsHeight,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: _ratingBoxClr),
                                                    color: Colors.grey.shade200
                                                        .withOpacity(0.25)),
                                                child: Center(
                                                  child: Center(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Icon(
                                                            Icons.star,
                                                            color:
                                                                _ratingBoxClr,
                                                          )),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Text(
                                                          selectedTechnician
                                                                  ?.rating
                                                                  ?.toString() ??
                                                              "0.0",
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              color:
                                                                  _ratingBoxClr),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "Rating",
                                                          style: TextStyle(
                                                              color:
                                                                  _ratingBoxClr,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))),
                              ),
                              //=======completed box=======
                              Expanded(
                                flex: 1,
                                child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Align(
                                        alignment: Alignment.topCenter,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10.0, sigmaY: 10.0),
                                            child: Material(
                                              color: Colors.white54,
                                              child: Container(
                                                width: _statsWidth,
                                                height: _statsHeight,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    border: Border.all(
                                                        width: 2,
                                                        color:
                                                            _completedBoxClr),
                                                    color: Colors.grey.shade200
                                                        .withOpacity(0.25)),
                                                child: Center(
                                                  child: Center(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Icon(
                                                            Icons.handshake,
                                                            color:
                                                                _completedBoxClr,
                                                          )),
                                                      Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Text(
                                                          "${selectedTechnician?.completionRate?.toString()}"
                                                          "%",
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              color:
                                                                  _completedBoxClr),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Align(
                                                        //todo: Check if comp rate can be 0% when new user and use ??
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "Completion",
                                                          style: TextStyle(
                                                              color:
                                                                  _completedBoxClr,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))),
                              )
                            ],
                          ),

                          //=======desc box=======
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: Material(
                                        color: Colors.white54,
                                        child: InkWell(
                                          onTap: () {
                                            _showFullDesc();
                                          },
                                          child: AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 200),
                                            padding: EdgeInsets.all(12),
                                            // height: _isDescExpanded ? 150 : 100,
                                            // height: 100,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30)),
                                                border: Border.all(
                                                    width: 4,
                                                    color: Colors.white),
                                                color: Colors.white
                                                    .withOpacity(0.25)),
                                            child: Text(
                                              selectedTechnician?.techDesc ??
                                                  AppStrings.listOfReviews[1] +
                                                      AppStrings
                                                          .listOfReviews[2] +
                                                      AppStrings
                                                          .listOfReviews[1] +
                                                      AppStrings
                                                          .listOfReviews[1] +
                                                      AppStrings
                                                          .listOfReviews[1] +
                                                      AppStrings
                                                          .listOfReviews[1] +
                                                      AppStrings
                                                          .listOfReviews[1] +
                                                      AppStrings
                                                          .listOfReviews[1] +
                                                      AppStrings
                                                          .listOfReviews[1] +
                                                      AppStrings
                                                          .listOfReviews[1] +
                                                      AppStrings
                                                          .listOfReviews[1] +
                                                      AppStrings
                                                          .listOfReviews[1] +
                                                      AppStrings
                                                          .listOfReviews[1] +
                                                      AppStrings
                                                          .listOfReviews[1] +
                                                      AppStrings
                                                          .listOfReviews[1],
                                              maxLines:
                                                  _isDescExpanded ? 10 : 10,
                                              overflow: TextOverflow.ellipsis,
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

                              //=======portfolio button=======
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  width: double.infinity,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0, 4), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PortfolioSummary(
                                                        selectedTechnician!
                                                            .technicianUid!)));
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
                                                      fontWeight:
                                                          FontWeight.bold),
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

                              //=======reviews button=======
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  width: double.infinity,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: _btnColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      splashColor: _splashClr,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TechnicianReviews(
                                                      false,
                                                      selectedTechnician!
                                                          .technicianUid!)),
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
                                                      fontWeight:
                                                          FontWeight.bold),
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
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
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
                              "Loading...",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                );
              }
            }),
      ],
    );
  }

  Future<void> _showLoveDialog() async {
    onLikeButtonTapped(_isLiked!);
    debugPrint("----is liked? $_isLiked----");

    return showDialog<void>(
      context: context,
      // barrierColor: null,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Align(
                alignment: Alignment.center,
                child: Lottie.asset( _isLiked! ?
                    "assets/remove love ani.json" :
                "assets/love ani 2.json",
                controller: _lottieAnimationController,
                repeat: false,
                  animate: true,
                    height: 500,
                    width: 500,
                    onLoaded: (composition) {
                      _lottieAnimationController?.duration = composition.duration;
                      _lottieAnimationController?.forward();
                    }
          ),
          ),
        ));
      },
    );
  }

  Future<void> _showFullDesc() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              Container(
                  // height: 200,
                  width: MediaQuery.of(context).size.width,
                  // margin:
                  // EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.5),
                          child: Container(
                            padding: EdgeInsets.all(25),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                border:
                                    Border.all(width: 3, color: Colors.white),
                                color: Colors.grey.shade200.withOpacity(0.25)),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "Description\n",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${(selectedTechnician!.techDesc) ?? "No Description available"}",
                                      style: TextStyle(color: Colors.black54),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ))),
            ],
          ),
        );
      },
    );
  }
  @override
  void dispose() {
    _lottieAnimationController?.dispose();
    super.dispose();
  }


  final Color _btnColor = HexColor("#d4c4ca");
  final Color _splashClr = Colors.white;
  final Color _darkTxtClr = HexColor("#96878D");
  bool _isDescExpanded = false;
  double _statsHeight = 105;
  double _statsWidth = 105;
  final Color _jobsBoxClr = HexColor("#96878D");
  final Color _ratingBoxClr = HexColor("#96878D");
  final Color _completedBoxClr = HexColor("#96878D");

}
