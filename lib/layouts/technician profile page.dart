import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:technicians/layouts/portfolio%20summary.dart';
import 'package:technicians/layouts/technician%20reviews.dart';
import 'package:technicians/models/technician%20object.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'package:technicians/widgets/glass%20box.dart';
import 'package:technicians/widgets/navigation%20drawer.dart';
import 'package:technicians/widgets/slider.dart';

class TechnicianMainProfilePage extends StatefulWidget {
  final String selectedTechnicianUid;
  const TechnicianMainProfilePage(this.selectedTechnicianUid, {Key? key}) : super(key: key);

  @override
  State<TechnicianMainProfilePage> createState() => _TechnicianMainProfilePageState();
}

class _TechnicianMainProfilePageState extends State<TechnicianMainProfilePage> {

  Technician? selectedTechnician;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("widget.title"),
      ),
      body: assignedTechnicianProfileOnBoarding(),
    );
  }

  Future<void> getSelectedTechnician() async {
    var technicianCollection =
    FirebaseFirestore.instance.collection("technicians");

    //looking by trades
    await technicianCollection.where(
        AppStrings.technicianUidKey, isEqualTo: widget.selectedTechnicianUid) //TODO: change to dynamic
        .get().then((value) => {
      value.docs.forEach((element) {

        selectedTechnician = Technician(
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
      })
    });

  }

  Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// send your request here
    var ref = FirebaseFirestore.instance.collection("technicians");
    var uid = FirebaseAuth.instance.currentUser!.uid;
    List listFavs = selectedTechnician!.favouritedBy!;

    if(listFavs.contains(uid)){

      listFavs.remove(uid);
      await ref.doc(selectedTechnician!.technicianUid).set({
        AppStrings.listOfFavouritedByKey : listFavs ,
        AppStrings.numberOfFavouritesKey : listFavs.length,
      }, SetOptions(merge: true)).then((value) => isLiked = false);
    } else {

      listFavs.add(uid);
      await ref.doc(selectedTechnician!.technicianUid).set({
        AppStrings.listOfFavouritedByKey : listFavs ,
        AppStrings.numberOfFavouritesKey : listFavs.length,
      }, SetOptions(merge: true)).then((value) => isLiked = true);
    }

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return isLiked;
  }

  Widget assignedTechnicianProfileOnBoarding() {
    return FutureBuilder(
      future: getSelectedTechnician(),
        builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return Container(
          margin: EdgeInsets.fromLTRB(20, 16, 20, 80),
          child: ListView(
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true, // use this
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2)),
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
                            "${selectedTechnician?.firstName} ${selectedTechnician
                                ?.familyName}",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(height: 5),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            selectedTechnician?.jobTitle ?? "null",
                            maxLines: 1,
                            style: TextStyle(fontSize: 18,),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(onTap: () {},
                          child: LikeButton(
                            onTap: onLikeButtonTapped,
                            isLiked: true,
                          )),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "a short desc", //TODO: add in db
                            maxLines: 2,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FloatingActionButton.extended(
                                heroTag: 3,
                                label: Text("Reviews"),
                                onPressed: () =>
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TechnicianReviews(false,
                                                selectedTechnician!
                                                    .technicianUid!)),
                                  )
                                }),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: FloatingActionButton.extended(
                                  heroTag: 2,
                                  label: Text("portfolio"),
                                  onPressed: () => {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => PortfolioSummary(selectedTechnician!.technicianUid!)))
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
                                  selectedTechnician?.jobsCompleted?.toString() ??
                                      "-1",
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
                                  selectedTechnician?.rating?.toString() ?? "-1",
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
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "${selectedTechnician?.completionRate
                                      ?.toString()}" "%",
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
        )
    ;
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
        }
    );
  }

}
