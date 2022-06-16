import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:technicians/layouts/mark%20order%20as%20complete.dart';
import 'package:technicians/models/test%20issue%20object.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/utils/strings%20common%20issues.dart';
import 'package:technicians/utils/strings%20enum.dart';

class PendingAndCompletedOrders extends StatefulWidget {
  const PendingAndCompletedOrders({Key? key}) : super(key: key);

  @override
  State<PendingAndCompletedOrders> createState() =>
      _PendingAndCompletedOrdersState();
}

class _PendingAndCompletedOrdersState extends State<PendingAndCompletedOrders> {
  List<TestIssue> listOfAllIssues = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: getData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                return ordersList();
              } else {
                return Center(child: Text("Loading data..."),);
              }
            },
           ));
  }

  @override
  void initState() {
    debugPrint("Calling data fetch");
    listOfAllIssues.clear();
    super.initState();
  }

  Future<void> getData() async {
    debugPrint("Started fetching data");
    var issueCollection = FirebaseFirestore.instance.collection("issues");
    var user = FirebaseAuth.instance.currentUser;

    await issueCollection
        .where(AppStrings.issuedByKey, isEqualTo: user!.uid)
        .get()
        .then((value) {
      for (var element in value.docs) {
        TestIssue i = TestIssue(
          technicianRating: double.parse(element.data()[AppStrings.technicianRatingKey].toString()),
          isCompleted: element.data()[AppStrings.isCompletedKey],
          timeCompleted: element.data()[AppStrings.timeCompletedKey],
          timeRequested: element.data()[AppStrings.timeRequestedKey],
          issueDesc: element.data()[AppStrings.issueDescKey],
          isAcceptedByTechnician: element.data()[AppStrings.isAcceptedByTechnicianKey],
          isCanceledByUser: element.data()[AppStrings.isCanceledByUserKey],
          isEmergency: element.data()[AppStrings.isEmergencyKey],
          isPaid: element.data()[AppStrings.isPaidKey],
          issueCategory: element.data()[AppStrings.issueCategoryKey],
          issuedBy: element.data()[AppStrings.issuedByKey],
          //TODO: add "issued to"
          issueUid: element.data()[AppStrings.issueUidKey],
          paymentMethod: element.data()[AppStrings.paymentMethodKey],
          price: double.parse(element.data()[AppStrings.priceKey].toString()),
          technicianReview: element.data()[AppStrings.technicianReviewKey],
        );

        listOfAllIssues.add(i);
      }
    });
    debugPrint("# of issues: ${listOfAllIssues.length}");

  }

  Widget ordersList() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 80),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppStrings.listOfOrdersString,
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
          orders(),
        ],
      ),
    );
  }

  Widget orders() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: listOfAllIssues.length,
          itemBuilder: (context, index) {
            return Container(
                height: listOfAllIssues[index].isCompleted ? 250 : 200,
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(10.0), //or 15.0
                                    child: Container(
                                      height: 60.0,
                                      width: 60.0,
                                      color: Color(0xffFF0E58),
                                      child: Icon(Icons.gps_not_fixed_rounded,
                                          color: Colors.white, size: 50.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      listOfAllIssues[index].paymentMethod,
                                      style: TextStyle(
                                          color: listOfAllIssues[index].paymentMethod ==
                                                  "In App"
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.71,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 0, 16, 0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            listOfAllIssues[index].issueCategory,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 0, 16, 0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "\$${listOfAllIssues[index].price}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        listOfAllIssues[index].issueDesc,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(16, 5, 5, 5),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () => {},
                                                    //todo: change to issuedTo
                                                    text: listOfAllIssues[index].issuedBy,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.blue),
                                                  ),
                                                  TextSpan(
                                                      text: listOfAllIssues[index].
                                                      isCompleted
                                                          ? 'Completed by: '
                                                          : "Pending...  ",
                                                      style: TextStyle(
                                                          color: listOfAllIssues[index].isCompleted
                                                              ? Colors.green
                                                              : HexColor(
                                                                  "FFD700"))),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        listOfAllIssues[index].technicianRating.toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
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
                                  Container(
                                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        //TODO: convert this to date/timestamp
                                        listOfAllIssues[index].isCompleted
                                            ? listOfAllIssues[index].timeCompleted.toString()
                                            : listOfAllIssues[index].timeRequested.toString(),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: listOfAllIssues[index].isCompleted,
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(16, 5, 16, 0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          listOfAllIssues[index].technicianReview,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Visibility(visible: false, child: Text("Hello world")),
                        Visibility(
                          visible: !listOfAllIssues[index].isCompleted,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FloatingActionButton.extended(
                                heroTag: index,
                                label: Text(
                                  "Mark As Complete",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                onPressed: () => {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             MarkOrderFinished())),
                                  insertMockTechnicians()
                                },
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }

  Future<void> insertMockTechnicians() async {
    List listAllUserUIDs = [];
    var techniciansCollection = FirebaseFirestore.instance.collection("technicians");

    await FirebaseFirestore.instance.collection("users")
        .get()
        .then((value) {
      for (var element in value.docs) {

          listAllUserUIDs.add(element.data()[AppStrings.uidKey]);

      }
    });


    for(int i=0; i<100; i++){

      Random random = Random();
      List<double> listOfRatings = [1,1.5,2,2.5,3,3.5,4,4.5,5];
      List booleanList = [true,false];
      var firstName = (AppStrings.firstNamesList.toList()..shuffle()).first;
      var lastName=  (AppStrings.lastNamesList.toList()..shuffle()).first;

      Map<String, double> mapCommonIssuePrices = {};
      List listOfAppliancesSubscribed = [];
      List listOfUserFavourites = [];

      //generate a random number of appliances subscribed to
      for(int i=0;i<2;i++){
        String j = (CommonIssues.listOfTechnicianCategories.toList()..shuffle()).first;
        listOfAppliancesSubscribed.add(j);
        mapCommonIssuePrices[j] = double.parse(random.nextInt(100).toString());
      }

      //generate a random number of users that favourited
      for(int i=0;i<random.nextInt(10)+2;i++){
        listOfUserFavourites.add((listAllUserUIDs.toList()..shuffle()).first);
      }

      await techniciansCollection.add({
        AppStrings.technicianUidKey: " ",

      }).then((value) async => await FirebaseFirestore.instance
          .collection("technicians")
          .doc(value.id)
          .set ({
        AppStrings.firstNameKey              : firstName,
        AppStrings.familyNameKey              : lastName,
        AppStrings.jobTitleKey                : (CommonIssues.listOfTechnicianCategories.toList()..shuffle()).first,
        AppStrings.imageKey                   : null,
        AppStrings.overallRatingKey           : (listOfRatings.toList()..shuffle()).first,
        AppStrings.isAvailableKey             : (booleanList.toList()..shuffle()).first,
        AppStrings.jobsCompletedKey           : random.nextInt(100),
        AppStrings.jobsDeclinedKey            : random.nextInt(100),
        AppStrings.completionRateKey          : random.nextInt(100),
        AppStrings.jobsTerminatedMidWorkKey   : random.nextInt(100),
        AppStrings.requestAcceptanceRateKey   : random.nextInt(100),
        AppStrings.accountCreationTimeStampKey: random.nextInt(123456789),
        AppStrings.portfolioItemsKey          : random.nextInt(100),
        AppStrings.isPreferredKey             : (booleanList.toList()..shuffle()).first,
        AppStrings.phoneNumberKey             : random.nextInt(123456789),
        AppStrings.emailKey                   : ("$firstName$lastName@gmail.com"),
        AppStrings.jobsPaidPhysicallyKey      : random.nextInt(100),
        AppStrings.jobsPaidThroughAppKey      : random.nextInt(100),
        AppStrings.isVerifiedByIdKey          : (booleanList.toList()..shuffle()).first,
        AppStrings.appliancesSubscribedToKey  : listOfAppliancesSubscribed,
        AppStrings.mapPricesOfIssuesKey       : mapCommonIssuePrices,
        AppStrings.isAvailableForEmergenciesKey: (booleanList.toList()..shuffle()).first,
        AppStrings.numberOfFavouritesKey      : listOfUserFavourites.length,
        AppStrings.numberOfReviewsKey         : random.nextInt(100),
        AppStrings.locationKey                : (AppStrings.locationsList.toList()..shuffle()).first,
        AppStrings.listOfFavouritedByKey      : listOfUserFavourites,
      }));
      }

    }
    }


