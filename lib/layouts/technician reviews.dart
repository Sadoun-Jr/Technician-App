import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:technicians/models/review%20object.dart';

import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/utils/strings%20enum.dart';

class TechnicianReviews extends StatefulWidget {
  final String selectedTechnicianUid;
  const TechnicianReviews(this.selectedTechnicianUid,{Key? key}) : super(key: key);

  @override
  State<TechnicianReviews> createState() => _TechnicianReviewsState();
}

class _TechnicianReviewsState extends State<TechnicianReviews> {

  List<Review> listOfReviews = [];

  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: getReviews(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              return reviewsListView();
              // return FloatingActionButton(onPressed: insertMockIssues);
            } else {
              return Center(child: Text("Loading data..."),);
            }
          },
        ));
  }

  Future<String> changeUidToName(String uid, bool isUser) async {
    String? firstName;
    String? familyName;

    var myRef = isUser? FirebaseFirestore.instance.collection("users") :
        FirebaseFirestore.instance.collection("technicians");
    await myRef.where(isUser ? AppStrings.userUidKey : AppStrings.technicianUidKey,
    isEqualTo: uid).get().then((value) => {
    for (var element in value.docs) {
      firstName =
        element.data()[AppStrings.firstNameKey],
      familyName =
      element.data()[AppStrings.familyNameKey],
    }
    });

    return "$firstName $familyName";
  }

  Future<void> getReviews() async {
    try{

      debugPrint("Started getting reviews for uid ${widget.selectedTechnicianUid}");
      var issuesRef = FirebaseFirestore.instance.collection("issues");
      await issuesRef
          .where(AppStrings.issuedToKey, isEqualTo: widget.selectedTechnicianUid)
          .get()
          .then((value) async {

        value.docs.forEach((element) {
          Review i = Review(
            price: element.data()[AppStrings.priceKey],
            paymentMethod: element.data()[AppStrings.paymentMethodKey],
            issueUid: element.data()[AppStrings.issueUidKey],
            issuedBy: element.data()[AppStrings.issuedByKey],
            issueDesc: element.data()[AppStrings.issueDescKey],
            //TODO: unify the var and key names
            issueTitle: element.data()[AppStrings.issueCategoryKey],
            isLeftMidWork: element.data()[AppStrings.isTerminatedMidWork],
            issuedTo: element.data()[AppStrings.issuedToKey],
            rating: element.data()[AppStrings.technicianRatingKey].toString(),
            reviewDesc: element.data()[AppStrings.technicianReviewKey],
            timeOfReview: element.data()[AppStrings.timeCompletedKey],
          );
          listOfReviews.add(i);

        });

      });
      debugPrint("the technician has ${listOfReviews.length} reviews");

    } catch (e) {
      debugPrint(e.toString());
    }

  }


  Widget reviewsListView() {
    return FutureBuilder(
      future: getReviews(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
                          "Reviews of widgets.name",
                          style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold),
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
                      itemCount: listOfReviews.length,
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
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15)),
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
                                              EdgeInsets.fromLTRB(
                                                  0, 23, 16, 16),
                                              color: Colors.transparent,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      Text(
                                                        listOfReviews[index].rating!,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .fromLTRB(5, 0, 16,
                                                            0),
                                                        child: Icon(
                                                          Icons.star,
                                                          size: 16,
                                                          color: HexColor(
                                                              "FFD700"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    listOfReviews[index].issuedBy!
                                                     ,
                                                    style: TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    listOfReviews[index].issueDesc!,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey
                                                            .shade600,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                    maxLines: 1,
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    listOfReviews[index].reviewDesc!,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey
                                                            .shade600,
                                                        fontWeight: FontWeight
                                                            .bold),
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
        else {
          return Center(child: Text("Loading reviews..."));
        }
      });

  }

}
