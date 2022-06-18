import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:technicians/models/review%20object.dart';
import 'package:technicians/models/test%20issue%20object.dart';

import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'package:technicians/widgets/navigation%20drawer.dart';
import 'package:technicians/widgets/slider.dart';

class TechnicianReviews extends StatefulWidget {
  final String? selectedTechnicianUid;
  final bool isUserReviews;
  const TechnicianReviews(this.isUserReviews, this.selectedTechnicianUid, {Key? key})
      : super(key: key);

  @override
  State<TechnicianReviews> createState() => _TechnicianReviewsState();
}

class _TechnicianReviewsState extends State<TechnicianReviews> {
  List<TestIssue> listOfReviews = [];
  List<String> listOfNamesFromUid = [];
  List<TestIssue> listOfAllIssues = [];
  String techNameFromUid = "null";
  late bool isAccessedFromDashboard;

  @override
  void initState() {
    isAccessedFromDashboard = widget.isUserReviews;
    debugPrint(isAccessedFromDashboard ? "Displaying all user reviews" :
    "Displaying technician UID: " + widget.selectedTechnicianUid! + " reviews");
    listOfAllIssues.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
        appBar: isAccessedFromDashboard ? AppBar(
          elevation: 0.0,
          title: Text("widget.title"),
        ) : null,
        body: FutureBuilder(
      future: isAccessedFromDashboard ? getUserReviews() : getTechnicianReviews(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return reviewsListView();
          // return FloatingActionButton(onPressed: insertMockIssues);
        } else {
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                slider(),
                SizedBox(
                  height: 10.5,
                ),
                Text("Loading data..."),
              ],
            ),
          );
        }
      },
    ));
  }

  Future<void> getTechnicianReviews() async {
    debugPrint("Started fetching reviews");
    var issueCollection = FirebaseFirestore.instance.collection("issues");
    var user = FirebaseAuth.instance.currentUser;
    techNameFromUid = (await changeUidToName(widget.selectedTechnicianUid!, false));

    await issueCollection
        .where(AppStrings.issuedToKey,
        isEqualTo:
        widget.selectedTechnicianUid) //TODO: change this to dynamic
        .get()
        .then((value) async {
      for (var element in value.docs) {
        TestIssue i = TestIssue(
          technicianRating: double.parse(
              element.data()[AppStrings.technicianRatingKey].toString()),
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
          price: double.parse(element.data()[AppStrings.priceKey].toString()),
          technicianReview: element.data()[AppStrings.technicianReviewKey],
          issuedTo: element.data()[AppStrings.issuedToKey],
        );

        listOfAllIssues.add(i);

        Future<String> name = changeUidToName(i.issuedBy, true);
        listOfNamesFromUid.add(await name);
      }
    });
    debugPrint("# of names: ${listOfNamesFromUid.length}");
    debugPrint("# of issues: ${listOfAllIssues.length}");
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

  Future<void> getUserReviews() async {
    debugPrint("Started fetching user reviews");
    var issueCollection = FirebaseFirestore.instance.collection("issues");
    var user = FirebaseAuth.instance.currentUser;

    await issueCollection
        .where(AppStrings.issuedByKey,
            isEqualTo:
                "Cnhhl65d7vTgo8L9ehKe") //TODO: change this to dynamic
        .get()
        .then((value) async {
      for (var element in value.docs) {
        TestIssue i = TestIssue(
          technicianRating: double.parse(
              element.data()[AppStrings.technicianRatingKey].toString()),
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
          price: double.parse(element.data()[AppStrings.priceKey].toString()),
          technicianReview: element.data()[AppStrings.technicianReviewKey],
          issuedTo: element.data()[AppStrings.issuedToKey],
        );

        listOfAllIssues.add(i);

        Future<String> name = changeUidToName(i.issuedTo, false);
        listOfNamesFromUid.add(await name);
      }
    });
    debugPrint("# of names: ${listOfNamesFromUid.length}");
    debugPrint("# of issues: ${listOfAllIssues.length}");
  }

  Widget reviewsListView() {
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
                  Visibility(
                    visible: !isAccessedFromDashboard ,
                    child: Text(
                      "Reviews of " + techNameFromUid,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: listOfAllIssues.length,
                itemBuilder: (context, index) {
                  return Container(
                      height: 175,
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
                          onTap: () => {},
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Row(children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
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
                                            Row(
                                              children: [
                                                Text(
                                                  listOfAllIssues[index]
                                                      .technicianRating
                                                      .toString(),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      5, 0, 16, 0),
                                                  child: Icon(
                                                    Icons.star,
                                                    size: 16,
                                                    color: HexColor("FFD700"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              listOfNamesFromUid[index],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              listOfAllIssues[index].issueDesc,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              listOfAllIssues[index]
                                                  .technicianReview,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 3,
                                            ),
                                          ],
                                        ),
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
}
