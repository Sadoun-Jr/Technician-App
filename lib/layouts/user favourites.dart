import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:technicians/layouts/technician%20profile%20page.dart';
import 'package:technicians/models/technician%20object.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/utils/strings%20common%20issues.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'package:technicians/widgets/navigation%20drawer.dart';
import 'package:technicians/widgets/slider.dart';

class UserFavourites extends StatefulWidget {
  const UserFavourites({Key? key}) : super(key: key);

  @override
  State<UserFavourites> createState() => _UserFavouritesState();
}

class _UserFavouritesState extends State<UserFavourites> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Color _btnColor = HexColor("#96878D");
  final Color _splashClr = Colors.white;
  final Color _lightPrimary = HexColor("#d4c4ca");
  late Future<void> getFavsData;

  @override
  void initState() {
    super.initState();
    getFavsData = getAppropriateTechnicians();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // leadingWidth: 50,
        toolbarHeight: MediaQuery.of(context).size.height / 10,
        backgroundColor: HexColor("#96878D"),
        title: Text("My Favourites"),
        leading: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: IconButton(
            icon: Icon(Icons.list),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom:
                Radius.circular(15)
                    // Radius.elliptical(MediaQuery.of(context).size.width, 32)
            )),
      ),
      body: listOfFavTechniciansLayout(),
    );
  }

  int selectTechnicianValue = -1;
  List<Technician> listOfFavTechnicians = [];

  Future<void> getAppropriateTechnicians() async {

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // debugPrint('connected');
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "No internet connection", backgroundColor: Colors.red);
      return;
    }

    listOfFavTechnicians = [];
    var technicianCollection =
        FirebaseFirestore.instance.collection("technicians");
    var uid = FirebaseAuth.instance.currentUser!.uid;

    //looking by trades
    await technicianCollection
        .where(AppStrings.listOfFavouritedByKey,
            arrayContains:
                uid) //TODO: change to dynamic
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                Technician technician = Technician(
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
                listOfFavTechnicians.add(technician);
              })
            });
    debugPrint("list of appropriate techs has: ${listOfFavTechnicians.length}");
  }

  Widget listOfFavTechniciansLayout() {
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
            future: getFavsData,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                listOfFavTechnicians.toSet().toList();
                debugPrint(
                    "Filtered list of appropriate techs to: ${listOfFavTechnicians.length}");
                return Container(
                  margin: EdgeInsets.fromLTRB(8, 5, 8, 5),
                  height: MediaQuery.of(context).size.height,
                  child: listOfFavTechnicians.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: listOfFavTechnicians.length,
                          itemBuilder: (context, index) {
                            return Container(
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
                                    child: Material(
                                      color: Colors.white54,
                                      child: Container(
                                        width: double.infinity,
                                        height: 90,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            border: Border.all(
                                                width: 3,
                                                color: Colors.white),
                                                ),
                                        child: InkWell(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          splashColor: _splashClr,
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => TechnicianMainProfilePage(
                                                      listOfFavTechnicians[index].technicianUid!)))
                                              ,
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
                                                            listOfFavTechnicians[index]
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
                                                                      backgroundColor:
                                                                          Colors.white70,
                                                                      maxRadius:
                                                                          28.5,
                                                                      backgroundImage:
                                                                          NetworkImage(listOfFavTechnicians[index].image!),
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
                                                                visible: listOfFavTechnicians[
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
                                                                  listOfFavTechnicians[index]
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
                                                                  listOfFavTechnicians[index]
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
                                                            Expanded(
                                                              child: Text(
                                                                listOfFavTechnicians[index]
                                                                        .jobTitle ??
                                                                    "null",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600,
                                                                    fontWeight:
                                                                        FontWeight.bold),
                                                                maxLines: 1,
                                                              ),
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
                                                                  SizedBox(
                                                                      height:
                                                                          7),
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
                              ),
                            );
                          })
                      : Center(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Lottie.asset(
                                  "assets/searching.json",
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "No Favourites, start liking some technicians!",
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                );
              } else {
                return SizedBox(
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
}
