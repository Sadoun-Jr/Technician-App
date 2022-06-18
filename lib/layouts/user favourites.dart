import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          elevation: 0.0,
          title: Text("widget.title"),
        ),
      body: listOfFavTechniciansLayout(),
    );
  }
  int selectTechnicianValue = -1;
  List<Technician> listOfFavTechnicians = [];

  Future<void> getAppropriateTechnicians() async {
    listOfFavTechnicians = [];
    var technicianCollection =
    FirebaseFirestore.instance.collection("technicians");

    //looking by trades
      await technicianCollection.where(
          AppStrings.listOfFavouritedByKey, arrayContains: "Ccrjx2juHMjCGauVhUwB") //TODO: change to dynamic
          .get().then((value) => {
        value.docs.forEach((element) {
          Technician technician = Technician(
            technicianUid: element.data()[AppStrings.technicianUidKey],
            accountCreationTimeStamp: element.data()[AppStrings.accountCreationTimeStampKey],
            appliancesSubscribedTo: element.data()[AppStrings.appliancesSubscribedToKey],
            completionRate: element.data()[AppStrings.completionRateKey],
            email: element.data()[AppStrings.emailKey],
            familyName: element.data()[AppStrings.familyNameKey],
            favouritedBy: element.data()[AppStrings.listOfFavouritedByKey],
            image: element.data()[AppStrings.imageKey],
            isAvailable: element.data()[AppStrings.isAvailableKey], //CHECK THIS
            isVerifiedById: element.data()[AppStrings.isVerifiedByIdKey],
            isPreferred: element.data()[AppStrings.isPreferredKey],
            jobsCompleted: element.data()[AppStrings.jobsCompletedKey],
            jobsDeclined: element.data()[AppStrings.jobsDeclinedKey],
            numberOfJobsPaidPhysically: element.data()[AppStrings.jobsPaidPhysicallyKey],
            numberOfJobsPaidThroughApp: element.data()[AppStrings.jobsPaidThroughAppKey],
            numberOfJobsTerminatedMidWork: element.data()[AppStrings.jobsTerminatedMidWorkKey],
            location: element.data()[AppStrings.locationKey],
            jobTitle: element.data()[AppStrings.jobTitleKey], //NULL, ADD IT IN DB
            pricesForJobIssues: element.data()[AppStrings.mapPricesOfJobIssuesKey],
            pricesForAppliancesSubscribedToIssues: element.data()[AppStrings.mapPricesOfApplianceIssuesKey],
            numberOfFavourites: element.data()[AppStrings.numberOfFavouritesKey],
            rating: double.parse(element.data()[AppStrings.overallRatingKey].toString()),
            phoneNumber: element.data()[AppStrings.phoneNumberKey],
            requestAcceptanceRate: element.data()[AppStrings.requestAcceptanceRateKey],
            firstName: element.data()[AppStrings.firstNameKey],
            personalDesc: element.data()[AppStrings.issueDescKey],
            numberOfPortfolioItems: element.data()[AppStrings.portfolioItemsKey],
            numberOfReviews: element.data()[AppStrings.numberOfReviewsKey],
          );
          listOfFavTechnicians.add(technician);
        })
      });
      debugPrint("list of appropriate techs has: ${listOfFavTechnicians.length}");

  }


  Widget listOfFavTechniciansLayout() {
    return FutureBuilder(
        future: getAppropriateTechnicians(),
        builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
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
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: listOfFavTechnicians.length,
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15)),
                                    splashColor: Colors.redAccent,
                                      onTap: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TechnicianMainProfilePage(
                                                      listOfFavTechnicians[index].technicianUid!)
                                          ),
                                        )
                                      },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                      child: Row(children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                                                child: Stack(
                                                    children:[
                                                      CircleAvatar(
                                                        // backgroundImage:
                                                        // AppStrings.techniciansList[index].image,
                                                        backgroundColor: Colors.grey,
                                                        maxRadius: 30,
                                                      ),
                                                      Align(
                                                        alignment: Alignment.bottomCenter,
                                                        child: Visibility(
                                                          visible: listOfFavTechnicians[index]
                                                              .isAvailable,
                                                          child: CircleAvatar(
                                                              maxRadius: 7,
                                                              backgroundColor: Colors.green
                                                          ),
                                                        ),
                                                      )
                                                    ]
                                                ),
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
                                                        listOfFavTechnicians[index]
                                                            .firstName ?? "null",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 6,
                                                      ),
                                                      Text(
                                                        listOfFavTechnicians[index]
                                                            .jobTitle ?? "null",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.grey
                                                                .shade600,
                                                            fontWeight:
                                                            FontWeight.bold),
                                                        maxLines: 1,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(16,16,0,16),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            listOfFavTechnicians[index]
                                                                .rating.toString(),
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: listOfFavTechnicians[index]
                                                                    .isAvailable
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

          } else{
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
            );        }
        });

  }

}
