import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:technicians/layouts/set%20personal%20details.dart';

import '../utils/strings common issues.dart';
import '../utils/strings enum.dart';

class OnboardingOption2 extends StatefulWidget {
  const OnboardingOption2({Key? key}) : super(key: key);

  @override
  State<OnboardingOption2> createState() => _OnboardingOption2State();
}

class _OnboardingOption2State extends State<OnboardingOption2> {
  @override
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: IntroductionScreen(
          scrollPhysics: ScrollPhysics(),
          rtl: true,
          rawPages: [
            singleIntroPage('أهلا و سهلا', 'أهلا بيك في عيلة صلحلي', 'المكان الصح عشان تصلح أي حاجة في بيتك','assets/Hello.png'),
            // singleIntroPage('حرية الاختيار', 'اختار الجهاز اللي عايز يتصلح أو اختار صنايعي معين', '','assets/Broken light bulb.png'),
            singleIntroPage('وصف المشكلة', 'اكتب وصف المشكلة و حط صور ليها براحتك', 'و اختار الصنايعي اللي انت عايزه من الاختيارات','assets/Broken light bulb.png'),
            singleIntroPage('سهولة الحساب', 'الصنايعي بيحددلك السعر و ليك حرية القبول أو الرفض', 'بعد ما بيخلص شغل هتدفع الرقم اللي متفقين عليه','assets/Wallet.png'),
            singleIntroPage('تقييم', 'متنساش تقيم الصنايعي بعد الشغل عشان تساعد غيرك', 'و لو في أي مشكلة تقدر تبلغ عن الصنايعي','assets/Rate.png'),
            singleIntroPage('يلا بينا', 'عرفنا بنفسك شوية عشان نبتدي', 'املا البيانات اللي مطلوبة فالصفحة اللي جاية','assets/Fill out.png'),

          ],
          onDone: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SetPersonalDetails(
                      false,
                      true,
                      gender: null,
                      city: null,
                      age: null,
                      profilePicLink: null,
                      firstName: null,
                      familyName: null,
                      province: null,
                      phoneNumber: null,
                    )));
          },
          showBackButton: false,
          showNextButton: false,
          showSkipButton: true,
          skip: const Text("Skip"),
          onSkip: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SetPersonalDetails(
                      false,
                      true,
                      gender: null,
                      city: null,
                      age: null,
                      profilePicLink: null,
                      firstName: null,
                      familyName: null,
                      province: null,
                      phoneNumber: null,
                    )));
          },
          done:
          const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget singleIntroPage(String title, String subtitleLine1, String subtitleLine2, String imageAsset) {
    return Stack(
      children: [
        bgImg(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            children: [
              Expanded(flex: 1, child: Image.asset(imageAsset)),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(subtitleLine1, style: TextStyle(fontSize: 18))),
                      Align(
                          alignment: Alignment.center,
                          child: Text(subtitleLine2, style: TextStyle(fontSize: 18))),
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget bgImg() {
    return Hero(
      tag: "bg",
      child: Image.asset(
        "assets/abstract bg.jpg",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
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

}
