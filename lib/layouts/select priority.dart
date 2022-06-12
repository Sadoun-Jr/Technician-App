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
var isNextButtonVisible = false;
var isCategoryChosen = false;

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pop(context);
  }

  void turnOnPrioritySelected() {
    isNextButtonVisible = true;
    setState(
      () => prioritySelected = true,
    );
  }

  void categorySelected() {
    isNextButtonVisible = true;
    setState(() => isCategoryChosen = true);
  }

  void switchNextButtonVisibility(bool visibile) {
    if (visibile){
      isNextButtonVisible = true;
    } else {
      isNextButtonVisible = false;
    }
    setState(() => isCategoryChosen = true);
  }

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
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
                child: (

                    //TODO: make this a progress button ...?
                    Icon(
                  prioritySelected ? Icons.add : Icons.facebook,
                  size: 35,
                )),
              ),
            ),
          ),

          rawPages: [
            selectEmergencyOnboarding(),
            selectCategoryOnboarding(),
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
          showNextButton: true,
          showSkipButton: false,
          freeze: true,
          showBackButton: true,
          // onChange: (page) {
          //   setState(() => isNextButtonVisible = false);
          // },

          // showNextButton: false,
          // rtl: true, // Display as right-to-left
          back: const Icon(Icons.arrow_back),
          skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
          next: Icon(
            Icons.arrow_forward,
          ),

          done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: DotsDecorator(
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
      ]),
    );
  }

  int _value = -1;

  Widget selectCategoryOnboarding() {
    return Container(
        margin: EdgeInsets.fromLTRB(40, 80, 40, 60),
        child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              categoryItemRow(1, "this is value 1", 2, "This is value 2"),
              categoryItemRow(3, "this is value 3", 4, "This is value 4"),
              categoryItemRow(5, "this is value 5", 6, "This is value 6"),
              categoryItemRow(7, "this is value 7", 8, "This is value 8"),
              categoryItemRow(9, "this is value 9", 10, "This is value 10"),

            ]));
  }

  Widget categoryItemRow(int selectedValueFirst, String textFirst,
      int selectedValueSecond, String textSecond) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: InkWell(
              onTap: () => setState(() => _value = selectedValueFirst),
              child: Container(
                height: 56,
                width: 56,
                child: Center(child: Text(textFirst)),
                decoration: BoxDecoration(
                    color: _value == selectedValueFirst ? Colors.grey : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
            ),
          ),
          Spacer(),
          Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: InkWell(
              onTap: () => setState(() => _value = selectedValueSecond),
              child: Container(
                height: 56,
                width: 56,
                child: Center(child: Text(textSecond)),
                decoration: BoxDecoration(
                    color: _value == selectedValueSecond ? Colors.grey : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectEmergencyOnboarding() {
    return Container(
      margin: EdgeInsets.all(30),
      child: ListView(
        children: [
          SizedBox(
            height: 100,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              AppStrings.selectPriorityString,
            ),
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
}
