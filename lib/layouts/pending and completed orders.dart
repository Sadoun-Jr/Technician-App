import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import 'package:technicians/layouts/mark%20order%20as%20complete.dart';
import 'package:technicians/models/test%20issue%20object.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/utils/strings%20common%20issues.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'package:technicians/widgets/navigation%20drawer.dart';
import 'package:technicians/widgets/slider.dart';

class PendingAndCompletedOrders extends StatefulWidget {
  const PendingAndCompletedOrders({Key? key}) : super(key: key);

  @override
  State<PendingAndCompletedOrders> createState() =>
      _PendingAndCompletedOrdersState();
}

class _PendingAndCompletedOrdersState extends State<PendingAndCompletedOrders> {
  List<TestIssue> listOfAllIssues = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: NavDrawer(),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leadingWidth: 50,
          toolbarHeight: MediaQuery.of(context).size.height / 10,
          backgroundColor: HexColor("#96878D"),
          title: Text("My Orders"),
          leading: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              icon: Icon(Icons.list),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
               bottom: Radius.circular(5)))
                  // bottom: Radius.elliptical(
                  //     MediaQuery.of(context).size.width, 32))),
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
            FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ordersList();
                  // return FloatingActionButton(onPressed: updateJustOneField);
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
              },
            ),
          ],
        ));
  }

  Future<void> updateJustOneField() async {
    var collectionReference = FirebaseFirestore.instance.collection("issues");
    collectionReference.doc("O9IqTGVpbstNGJRHSTeP").set(
        {"price": 3242365234}, SetOptions(merge: true)).whenComplete(() async {
      print("Completed");
    }).catchError((e) => print(e));
  }

  List<String> listOfNamesFromUid = [];

  Future<void> getData() async {
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
      debugPrint("Started fetching data");
      var issueCollection = FirebaseFirestore.instance.collection("issues");
      var user = FirebaseAuth.instance.currentUser;

      await issueCollection
          .where(AppStrings.issuedByKey, isEqualTo: user?.uid)
          .get()
          .then((value) async {
        for (var element in value.docs) {
          bool ratingNotZero =
              element.data()[AppStrings.technicianRatingKey] > 0;
          bool priceNotZero = element.data()[AppStrings.priceKey] > 0;
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
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
          msg: "Error fetching data", backgroundColor: Colors.red);
    }
  }

  Widget ordersList() {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: orders(),
    );
  }

  Future<void> _orderDetails(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              // margin:
              // EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.5),
                      child: Container(
                        padding: EdgeInsets.all(25),
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 2, color: Colors.white),
                            color: Colors.grey.shade200.withOpacity(0.25)),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  listOfAllIssues[index].issueDesc!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                            SizedBox(
                              height: 12.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))),
        );
      },
    );
  }

  Widget orders() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10);
          },
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: listOfAllIssues.length,
          itemBuilder: (context, index) {
            //                             .toString(),
            return ClipRRect(
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
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent),
                                  height: 60.0,
                                  width: 60.0,
                                  child: Image.asset(CommonIssues
                                          .mapOfSelectedImages[
                                      listOfAllIssues[index].issueCategory]!),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              //========description========
                              Flexible(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        listOfAllIssues[index].issueDesc!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      //========status========
                                      children: [
                                        Visibility(
                                          visible: !listOfAllIssues[index]
                                              .isCompleted!,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              listOfAllIssues[index]
                                                      .isAcceptedByTechnician!
                                                  ? "Status: Being worked on by "
                                                  : "Status: Waiting for technician response",
                                              style: TextStyle(
                                                  color: Colors.orange[700]),
                                            ),
                                          ),
                                        ),
                                        //todo: this will be status:terminated mid work
                                        Visibility(
                                          visible: !listOfAllIssues[index]
                                              .isCompleted!,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(""),
                                          ),
                                        ),
                                        Visibility(
                                            visible: listOfAllIssues[index]
                                                .isCompleted!,
                                            child: Text(
                                              "Completed by: ",
                                              style: TextStyle(
                                                  color: Colors.green[800]),
                                            )),
                                        Expanded(
                                          child: Visibility(
                                            visible: listOfAllIssues[index]
                                                .isAcceptedByTechnician!,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    // ),
                                                    TextSpan(
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap =
                                                                () => {
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: "msg")
                                                                    },
                                                      //todo: change to issuedTo
                                                      text: listOfNamesFromUid[
                                                          index],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .brown[400]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    //========date=========
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text( listOfAllIssues[index].isCompleted! ? "Completed on: " + convertTimeFromDb(listOfAllIssues[index].timeCompleted!) :
                                              "Requested on: " +convertTimeFromDb(listOfAllIssues[index].timeRequested!),
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                        ),

                                        Visibility(
                                            visible: !listOfAllIssues[index].isCompleted!
                                            ,child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: IconButton(
                                            splashColor: Colors.white,
                                            onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                MarkOrderFinished())); },
                                            icon:Icon(Icons.done, color: Colors.green, size: 35,),
                                            //todo: change this according to if technician is willing to end
                                          ),
                                        ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //========price==========
                                        Visibility(
                                          visible:
                                              listOfAllIssues[index].price! > 0,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(listOfAllIssues[index]
                                                    .price!
                                                    .toString() +
                                                "\$"),
                                          ),
                                        ),
                                        //========rating==========
                                        Row(
                                          children: [
                                            Visibility(
                                              visible: listOfAllIssues[index]
                                                  .isCompleted!,
                                              child: Text(listOfAllIssues[index]
                                                  .technicianRating
                                                  .toString()),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Visibility(
                                                visible: listOfAllIssues[index]
                                                    .isCompleted!,
                                                child: Icon(Icons.star))
                                          ],
                                        ),
                                        //========payment method==========
                                        Row(
                                          children: [
                                            Visibility(
                                                visible: listOfAllIssues[index]
                                                    .isCompleted!,
                                              child: Text(listOfAllIssues[index].paymentMethod!),
                                                ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Visibility(
                                                visible: listOfAllIssues[index]
                                                    .isCompleted!,
                                                child: Icon(Icons.handshake_rounded))
                                          ],
                                        ),
                                        //=========review=========
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Visibility(child: Text(listOfAllIssues[index].technicianReview!),
                                      visible: listOfAllIssues[index]
                                          .isCompleted!,),

                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            );
          }),
    );
  }

  String convertTimeFromDb(int input) {
    var dt = DateTime.fromMillisecondsSinceEpoch(input);
    String date;

    return date = DateFormat('MM/dd/yyyy').format(dt); // 12/31/2000, 10:00 PM
  }

  Future<void> insertMockUsers() async {
    for (int i = 0; i < 30; i++) {
      Random random = Random();
      List booleanList = [true, false];
      var firstName = (AppStrings.firstNamesList.toList()..shuffle()).first;
      var lastName = (AppStrings.lastNamesList.toList()..shuffle()).first;

      List<String> listOfTechnicianFavourites = [];
      List<String> listOfAllTechnicians = [];

      await FirebaseFirestore.instance
          .collection("technicians")
          .get()
          .then((value) => {
                for (var element in value.docs)
                  {
                    listOfAllTechnicians
                        .add(element.data()[AppStrings.technicianUid])
                    //TODO: change to userUid after creating mock users
                  }
              });

      //generate a random number of users that favourited
      for (int i = 0; i < random.nextInt(10) + 2; i++) {
        listOfTechnicianFavourites
            .add((listOfAllTechnicians.toList()..shuffle()).first);
      }

      var usersCollection = FirebaseFirestore.instance.collection("users");

      await usersCollection.add({
        AppStrings.userUidKey: " ",
      }).then((value) async => await FirebaseFirestore.instance
              .collection("users")
              .doc(value.id)
              .set({
            AppStrings.userUidKey: value.id,
            AppStrings.firstNameKey: firstName,
            AppStrings.familyNameKey: lastName,
            AppStrings.imageKey: null,
            AppStrings.accountCreationTimeStampKey: random.nextInt(123456789),
            AppStrings.phoneNumberKey: random.nextInt(123456789),
            AppStrings.emailKey: ("$firstName$lastName@gmail.com"),
            AppStrings.jobsPaidPhysicallyKey: random.nextInt(100),
            AppStrings.jobsPaidThroughAppKey: random.nextInt(100),
            AppStrings.isVerifiedByIdKey:
                (booleanList.toList()..shuffle()).first,
            AppStrings.numberOfFavouritesKey: listOfTechnicianFavourites.length,
            AppStrings.numberOfReviewsKey: random.nextInt(100),
            AppStrings.locationKey:
                (AppStrings.locationsList.toList()..shuffle()).first,
          }));
    }
  }

  @override
  void initState() {
    debugPrint("Calling data fetch");
    listOfAllIssues.clear();
    super.initState();
  }
}

Future<void> insertMockIssues() async {
  User? user = FirebaseAuth.instance.currentUser;

  List<double> listOfRatings = [1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5];

  for (int i = 0; i < 300; i++) {
    Random random = Random();
    List booleanList = [true, false];
    bool randomBool = (booleanList.toList()..shuffle()).first;
    int randomTime = random.nextInt(123456789);
    double randomDouble = double.parse(random.nextInt(100).toString());

    var randomIssueCategory = (booleanList.toList()..shuffle()).first
        ? (CommonIssues.listOfTechnicianCategories.toList()..shuffle()).first
        : (CommonIssues.listOfAppliancesCategories.toList()..shuffle()).first;

    var firstName = (AppStrings.firstNamesList.toList()..shuffle()).first;
    var lastName = (AppStrings.lastNamesList.toList()..shuffle()).first;

    List<String> listOfAllUsers = [];
    List<String> listOfAllTechnicians = [];
    var issuesCollection = FirebaseFirestore.instance.collection("issues");

    await FirebaseFirestore.instance.collection("users").get().then((value) => {
          for (var element in value.docs)
            {listOfAllUsers.add(element.data()[AppStrings.userUidKey])}
        });

    await FirebaseFirestore.instance
        .collection("technicians")
        .get()
        .then((value) => {
              for (var element in value.docs)
                {
                  listOfAllTechnicians
                      .add(element.data()[AppStrings.technicianUid])
                }
            });

    await issuesCollection.add({
      AppStrings.userUidKey: " ",
    }).then((value) async => await FirebaseFirestore.instance
            .collection("issues")
            .doc(value.id)
            .set({
          AppStrings.issueCategoryKey: randomIssueCategory,
          AppStrings.issueDescKey:
              (CommonIssues.mapAllCommonIssues[randomIssueCategory]!.toList()
                    ..shuffle())
                  .first,
          AppStrings.isCompletedKey: randomBool,
          AppStrings.technicianRatingKey:
              (listOfRatings.toList()..shuffle()).first,
          AppStrings.technicianReviewKey:
              (AppStrings.listOfReviews.toList()..shuffle()).first,
          AppStrings.timeCompletedKey: randomTime + random.nextInt(12345659),
          AppStrings.timeRequestedKey: randomTime,
          AppStrings.paymentMethodKey: randomBool ? "In App" : "Physical",
          AppStrings.priceKey: randomDouble,
          AppStrings.issueUidKey: value.id,
          AppStrings.isEmergencyKey: randomBool,
          AppStrings.isPaidKey: randomBool,
          AppStrings.issuedByKey: ((listOfAllUsers).toList()..shuffle()).first,
          AppStrings.isAcceptedByTechnicianKey:
              (booleanList.toList()..shuffle()).first,
          AppStrings.isCanceledByUserKey:
              (booleanList.toList()..shuffle()).first,
          AppStrings.isTerminatedMidWork:
              (booleanList.toList()..shuffle()).first,
          AppStrings.issuedToKey:
              (listOfAllTechnicians.toList()..shuffle()).first
        }));
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

Future<void> insertMockTechnicians() async {
  List listAllUserUIDs = [];
  var techniciansCollection =
      FirebaseFirestore.instance.collection("technicians");

  await FirebaseFirestore.instance.collection("users").get().then((value) {
    for (var element in value.docs) {
      listAllUserUIDs.add(element.data()[AppStrings
          .userUidKey]); //TODO: change to userUid after creating mock users

    }
  });

  for (int i = 0; i < 100; i++) {
    Random random = Random();
    List<double> listOfRatings = [1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5];
    List booleanList = [true, false];
    var firstName = (AppStrings.firstNamesList.toList()..shuffle()).first;
    var lastName = (AppStrings.lastNamesList.toList()..shuffle()).first;

    Map<String, double> mapCommonJobTitleIssues = {};
    Map<String, double> mapCommonApplianceIssues = {};
    List listOfAppliancesSubscribed = [];
    List listOfUserFavourites = [];
    String jobTitle =
        (CommonIssues.listOfTechnicianCategories.toList()..shuffle()).first;

    //create prices for the job issues map
    List<String>? listOfJobTitleCommonIssues =
        CommonIssues.mapAllCommonIssues[jobTitle];
    double randomDouble = double.parse(random.nextInt(100).toString());
    mapCommonJobTitleIssues = {
      for (var item in listOfJobTitleCommonIssues!) item: randomDouble
    };

    //generate a random number of appliances subscribed to
    for (int i = 0; i < 2; i++) {
      String j =
          (CommonIssues.listOfAppliancesCategories.toList()..shuffle()).first;
      listOfAppliancesSubscribed.add(j);
    }

    //create prices for the appliance issues map
    for (int i = 0; i < listOfAppliancesSubscribed.length; i++) {
      List<String>? listOfApplianceCommonIssues =
          CommonIssues.mapAllCommonIssues[listOfAppliancesSubscribed[i]];
      double randomDouble = double.parse(random.nextInt(100).toString());
      mapCommonApplianceIssues = {
        for (var item in listOfApplianceCommonIssues!) item: randomDouble
      };
    }

    //generate a random number of users that favourited
    for (int i = 0; i < random.nextInt(10) + 2; i++) {
      listOfUserFavourites.add((listAllUserUIDs.toList()..shuffle()).first);
    }

    await techniciansCollection.add({
      AppStrings.technicianUidKey: " ",
    }).then((value) async => await FirebaseFirestore.instance
            .collection("technicians")
            .doc(value.id)
            .set({
          AppStrings.technicianUidKey: value.id,
          AppStrings.firstNameKey: firstName,
          AppStrings.familyNameKey: lastName,
          AppStrings.jobTitleKey: jobTitle,
          AppStrings.imageKey: null,
          AppStrings.overallRatingKey:
              (listOfRatings.toList()..shuffle()).first,
          AppStrings.isAvailableKey: (booleanList.toList()..shuffle()).first,
          AppStrings.jobsCompletedKey: random.nextInt(100),
          AppStrings.jobsDeclinedKey: random.nextInt(100),
          AppStrings.completionRateKey: random.nextInt(100),
          AppStrings.jobsTerminatedMidWorkKey: random.nextInt(100),
          AppStrings.requestAcceptanceRateKey: random.nextInt(100),
          AppStrings.accountCreationTimeStampKey: random.nextInt(123456789),
          AppStrings.portfolioItemsKey: random.nextInt(100),
          AppStrings.isPreferredKey: (booleanList.toList()..shuffle()).first,
          AppStrings.phoneNumberKey: random.nextInt(123456789),
          AppStrings.emailKey: ("$firstName$lastName@gmail.com"),
          AppStrings.jobsPaidPhysicallyKey: random.nextInt(100),
          AppStrings.jobsPaidThroughAppKey: random.nextInt(100),
          AppStrings.isVerifiedByIdKey: (booleanList.toList()..shuffle()).first,
          AppStrings.appliancesSubscribedToKey: listOfAppliancesSubscribed,
          AppStrings.mapPricesOfJobIssuesKey: mapCommonJobTitleIssues,
          AppStrings.mapPricesOfApplianceIssuesKey: mapCommonApplianceIssues,
          AppStrings.isAvailableForEmergenciesKey:
              (booleanList.toList()..shuffle()).first,
          AppStrings.numberOfFavouritesKey: listOfUserFavourites.length,
          AppStrings.numberOfReviewsKey: random.nextInt(100),
          AppStrings.locationKey:
              (AppStrings.locationsList.toList()..shuffle()).first,
          AppStrings.listOfFavouritedByKey: listOfUserFavourites,
        }));
  }
}
