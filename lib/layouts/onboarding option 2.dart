import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:technicians/layouts/set%20personal%20details.dart';

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

}
