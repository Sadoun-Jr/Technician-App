import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:technicians/models/review%20object.dart';
import 'package:technicians/models/test%20issue%20object.dart';

import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'package:technicians/widgets/navigation%20drawer.dart';
import 'package:technicians/widgets/slider.dart';

import '../utils/strings common issues.dart';

class TechnicianReviews extends StatefulWidget {
  final String? selectedTechnicianUid;
  final bool isUserReviews;
  const TechnicianReviews(this.isUserReviews, this.selectedTechnicianUid,
      {Key? key})
      : super(key: key);

  @override
  State<TechnicianReviews> createState() => _TechnicianReviewsState();
}

class _TechnicianReviewsState extends State<TechnicianReviews> {
  List<String> listOfNamesFromUid = [];
  List<TestIssue> listOfAllIssues = [];
  String techNameFromUid = "null";
  late bool isAccessedFromDashboard;
  late Future<void> getTechnicianReviewsInfo;
  late Future<void> getUserReviewsInfo;

  ///profile pics of users giving reviews to techs
  List<String> listOfUsersProfileImageLinks = [];

  @override
  void initState() {
    isAccessedFromDashboard = widget.isUserReviews;
    debugPrint(isAccessedFromDashboard
        ? "Displaying all user reviews"
        : "Displaying technician UID: " +
            widget.selectedTechnicianUid! +
            " reviews");
    listOfAllIssues.clear();
    if (widget.isUserReviews) {
      getUserReviewsInfo = getUserReviews();
    } else {
      getTechnicianReviewsInfo = getTechnicianReviews();
    }
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
        future: isAccessedFromDashboard
            ? getUserReviewsInfo
            : getTechnicianReviewsInfo,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                key: _scaffoldKey,
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  leadingWidth: 50,
                  toolbarHeight: MediaQuery.of(context).size.height / 10,
                  backgroundColor: HexColor("#96878D"),
                  title: Text('${techNameFromUid}\'s Reviews'),
                ),
                body: Stack(
                  children: [
                    Image.asset(
                      "assets/abstract bg.jpg",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                    reviewsListView(),
                  ],
                ));
            // return FloatingActionButton(onPressed:() {replaceMockTechnicians();} );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/abstract bg.jpg",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  Column(
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
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget reviewsListView() {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10);
          },
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: listOfAllIssues.length,
          itemBuilder: (context, index) {
            return Visibility(
              visible: listOfAllIssues[index].technicianReview!='na',
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Material(
                    color: Colors.white54,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      // onTap: () {
                      //   _orderDetails(index);
                      // },
                      child: Container(

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              border: Border.all(color: Colors.white, width: 3)),
                          // height: listOfAllIssues[index].isCompleted! ? 250 : 200,
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 4),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //======profile pic=========
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:listOfUsersProfileImageLinks[index] == 'na' ? Colors.white: Colors.transparent),
                                        height: 45.0,
                                        width: 45.0,
                                        child:
                                        listOfUsersProfileImageLinks[index] == 'na' ?
                                            Icon(Icons.person, color: Colors.black12,size: 36,)
                                            :
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(50)),
                                          child: Image.network(
                                              listOfUsersProfileImageLinks[index],
                                          fit: BoxFit.fill,),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    //=========name=========
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              listOfNamesFromUid[index],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //=======rating=======
                                              RatingBar.builder(
                                                initialRating: listOfAllIssues[index]
                                                    .technicianRating!,
                                                itemSize: 20,
                                                glowColor: Colors.transparent,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                ignoreGestures: true,
                                                itemCount: 5,
                                                itemPadding: EdgeInsets.symmetric(
                                                    horizontal: 1.0),
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) { },
                                              ),

                                              //=======date=======
                                              Text(convertTimeFromDb(listOfAllIssues[index].timeCompleted!)),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height:15,),
                                //=========desc=========
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    listOfAllIssues[index]
                                        .technicianReview != ' ' ? listOfAllIssues[index]
                                        .technicianReview! : 'No review made',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                        ),
                                    // maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            );
          }),
    );
  }

  List listOfAllUsers = [];
  List listOfAllTechs = [];

  Future<void> replaceMockTechnicians() async {
    var ref = FirebaseFirestore.instance.collection("users");
    ref.get().then((value) async => {
          for (var element in value.docs)
            {
              listOfAllUsers
                  .add(element.data()[AppStrings.userUidKey].toString())
            }
        });

    var techRef = FirebaseFirestore.instance.collection("technicians");
    techRef.get().then((value) async => {
          for (var element in value.docs)
            {
              listOfAllTechs
                  .add(element.data()[AppStrings.technicianUid].toString())
            }
        });

    for (int i = 0; i < listOfAllTechs.length; i++) {
      List listOfRandomUsers = [];

      for (int j = 0; j < Random().nextInt(10) + 2; j++) {
        listOfRandomUsers.add((listOfAllUsers.toList()..shuffle()).first);
      }

      techRef.doc(listOfAllTechs[i]).set({
        AppStrings.listOfFavouritedByKey: listOfRandomUsers,
        AppStrings.numberOfFavouritesKey: listOfRandomUsers.length,
      }, SetOptions(merge: true));
    }
  }

  Future<void> getTechnicianReviews() async {
    debugPrint("Started fetching reviews");

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
    try {
      var issueCollection = FirebaseFirestore.instance.collection('issues');
      var user = FirebaseAuth.instance.currentUser;
      techNameFromUid =
          (await changeUidToName(widget.selectedTechnicianUid!, false));

      await issueCollection
          .where(AppStrings.issuedToKey,
              isEqualTo:
                  widget.selectedTechnicianUid) //TODO: change this to dynamic
          .get()
          .then((value) async {
        for (var element in value.docs) {
          bool ratingNotZero =
              element.data()[AppStrings.technicianRatingKey] > 0 ?? 0;
          bool priceNotZero = element.data()[AppStrings.priceKey] > 0 ?? 0;

          TestIssue i = TestIssue(
              technicianRating: ratingNotZero
                  ? double.parse(
                      element.data()[AppStrings.technicianRatingKey].toString())
                  : 0,
              isCompleted: element.data()[AppStrings.isCompletedKey],
              timeCompleted: element.data()[AppStrings.timeCompletedKey],
              timeRequested: element.data()[AppStrings.timeRequestedKey],
              issueDesc: element.data()[AppStrings.issueDescKey],
              isAcceptedByTechnician:
                  element.data()[AppStrings.isAcceptedByTechnicianKey],
              isCanceledByUser: element.data()[AppStrings.isCanceledByUserKey],
              isEmergency: element.data()[AppStrings.isEmergencyKey],
              isPaid: element.data()[AppStrings.isPaidKey],
              issueCategory: element.data()[AppStrings.issueCategoryKey],
              issuedBy: element.data()[AppStrings.issuedByKey],
              issueUid: element.data()[AppStrings.issueUidKey],
              paymentMethod: element.data()[AppStrings.paymentMethodKey],
              price: priceNotZero
                  ? double.parse(element.data()[AppStrings.priceKey].toString())
                  : 0,
              technicianReview: element.data()[AppStrings.technicianReviewKey],
              issuedTo: element.data()[AppStrings.issuedToKey],
              listOfImages: element.data()[AppStrings.listOfImagePathskey]);

          listOfAllIssues.add(i);

          Future<String> profilePic = changeUidToProfilePic(i.issuedBy!, true);
          Future<String> name = changeUidToName(i.issuedBy!, true);
          listOfNamesFromUid.add(await name);
          listOfUsersProfileImageLinks.add(await profilePic);
        }
      });
      debugPrint("# of names: ${listOfNamesFromUid.length}");
      debugPrint("# of issues: ${listOfAllIssues.length}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> changeUidToName(String uid, bool isUser) async {
    String? firstName;
    String? familyName;

    var myRef = isUser
        ? FirebaseFirestore.instance.collection("users")
        : FirebaseFirestore.instance.collection("technicians");
    await myRef
        .where(isUser ? AppStrings.userUidKey : AppStrings.technicianUidKey,
            isEqualTo: uid)
        .get()
        .then((value) => {
              for (var element in value.docs)
                {
                  firstName = element.data()[AppStrings.firstNameKey],
                  familyName = element.data()[AppStrings.familyNameKey],
                }
            });

    return "$firstName $familyName";
  }

  Future<String> changeUidToProfilePic(String uid, bool isUser) async {
    String? picLink;

    var myRef = isUser
        ? FirebaseFirestore.instance.collection("users")
        : FirebaseFirestore.instance.collection("technicians");
    await myRef
        .where(isUser ? AppStrings.userUidKey : AppStrings.technicianUidKey,
            isEqualTo: uid)
        .get()
        .then((value) => {
              for (var element in value.docs)
                {
                  picLink = element.data()[AppStrings.imageKey],
                }
            });

    return picLink ?? 'na';
  }

  Future<void> getUserReviews() async {
    debugPrint("Started fetching user reviews");
    var issueCollection = FirebaseFirestore.instance.collection("issues");
    var user = FirebaseAuth.instance.currentUser;

    await issueCollection
        .where(AppStrings.issuedByKey,
            isEqualTo: "Cnhhl65d7vTgo8L9ehKe") //TODO: change this to dynamic
        .get()
        .then((value) async {
      for (var element in value.docs) {
        bool ratingNotZero =
            element.data()[AppStrings.technicianRatingKey] > 0 ?? 0;
        bool priceNotZero = element.data()[AppStrings.priceKey] > 0 ?? 0;

        TestIssue i = TestIssue(
            technicianRating: ratingNotZero
                ? double.parse(
                    element.data()[AppStrings.technicianRatingKey].toString())
                : 0,
            isCompleted: element.data()[AppStrings.isCompletedKey],
            timeCompleted: element.data()[AppStrings.timeCompletedKey],
            timeRequested: element.data()[AppStrings.timeRequestedKey],
            issueDesc: element.data()[AppStrings.issueDescKey],
            isAcceptedByTechnician:
                element.data()[AppStrings.isAcceptedByTechnicianKey],
            isCanceledByUser: element.data()[AppStrings.isCanceledByUserKey],
            isEmergency: element.data()[AppStrings.isEmergencyKey],
            isPaid: element.data()[AppStrings.isPaidKey],
            issueCategory: element.data()[AppStrings.issueCategoryKey],
            issuedBy: element.data()[AppStrings.issuedByKey],
            issueUid: element.data()[AppStrings.issueUidKey],
            paymentMethod: element.data()[AppStrings.paymentMethodKey],
            price: priceNotZero
                ? double.parse(element.data()[AppStrings.priceKey].toString())
                : 0,
            technicianReview: element.data()[AppStrings.technicianReviewKey],
            issuedTo: element.data()[AppStrings.issuedToKey],
            listOfImages: element.data()[AppStrings.listOfImagePathskey]);

        listOfAllIssues.add(i);

        Future<String> name = changeUidToName(i.issuedTo!, false);
        listOfNamesFromUid.add(await name);
      }
    });
    debugPrint("# of names: ${listOfNamesFromUid.length}");
    debugPrint("# of issues: ${listOfAllIssues.length}");
  }

  String convertTimeFromDb(int input) {
    var dt = DateTime.fromMillisecondsSinceEpoch(input);
    String date;

    return date = DateFormat('dd MMM yyyy').format(dt);
  }
}
