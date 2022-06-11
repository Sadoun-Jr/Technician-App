import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:technicians/utils/strings%20enum.dart';

class SelectPriority extends StatefulWidget {
  const SelectPriority({Key? key}) : super(key: key);

  @override
  State<SelectPriority> createState() => _SelectPriorityState();
}

class _SelectPriorityState extends State<SelectPriority> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

var prioritySelected = false;

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pop(context);
  }

  void turnOnPrioritySelected() {
    setState(() => prioritySelected = true);
  }

  Widget selectEmergencyOnboarding() {
    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.selectPriorityString,
          ),
          SizedBox(
            height: 100,
          ),
          FloatingActionButton.extended(
              backgroundColor: Colors.red,
              icon: Icon(Icons.emergency),
              heroTag: 1,
              onPressed: turnOnPrioritySelected,
              label: Text(AppStrings.immediately)),
          SizedBox(height: 20),
          FloatingActionButton.extended(
              backgroundColor: Colors.blueGrey,
              heroTag: 2,
              icon: Icon(Icons.lock_clock),
              onPressed: () => {},
              label: Text(AppStrings.appointment)),
        ],
      ),
    );
  }

  final pages = [
    Container(
      margin: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.selectPriorityString,
          ),
          SizedBox(
            height: 100,
          ),
          FloatingActionButton.extended(
              backgroundColor: Colors.red,
              icon: Icon(Icons.emergency),
              heroTag: 1,
              onPressed: ()=>{},
              label: Text(AppStrings.immediately)),
          SizedBox(height: 20),
          FloatingActionButton.extended(
              backgroundColor: Colors.blueGrey,
              heroTag: 2,
              icon: Icon(Icons.lock_clock),
              onPressed: () => {},
              label: Text(AppStrings.appointment)),
        ],
      ),
    ),
    Container(
        child: Center(
          child: Text("Hi daddy1"),
        )),
    Container(
        child: Center(
          child: Text("Hi mommy22"),
        )),
    Container(
        child: Center(
          child: Text("Hi daddy3 ?"),
        ))
  ];

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  //use the library read me as a reference
  //https://pub.dev/packages/introduction_screen

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    return Stack(children: [
      Image.asset(
        "assets/blurred_login.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
      IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.transparent,
        globalHeader: Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
              child: (Icon(Icons.facebook)),
            ),
          ),
        ),

        rawPages: [
          selectEmergencyOnboarding(),
          Container(
              child: Center(
            child: Text("Hi daddy1"),
          )),
          Container(
              child: Center(
            child: Text("Hi dad dy22"),
          )),
          Container(
              child: Center(
            child: Text("Hi daddy3 ?"),
          ))
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        skipOrBackFlex: 1,

        //prevent scrolling by swiping
        // freeze: true,

        isProgressTap: false,
        showNextButton: prioritySelected,
        showSkipButton: false,
        freeze: true,
        showBackButton: true,
        onChange: (page) {
        },
        // showNextButton: false,
        // rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back),
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),

        next: Icon(Icons.arrow_forward,

        ),

        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator:  DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    ]);
  }


}
