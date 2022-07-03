import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:technicians/layouts/stats.dart';
import 'package:technicians/utils/egypt%20cities.dart';

import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/utils/strings%20enum.dart';


import '../widgets/navigation drawer.dart';

class TestDashboard extends StatefulWidget {
  const TestDashboard({Key? key}) : super(key: key);

  @override
  State<TestDashboard> createState() => _TestDashboardState();
}

class _TestDashboardState extends State<TestDashboard> {

  @override
  void initState() {
    super.initState();


  }


  //TODO: get profile image and display it here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Row(
          children: const [
            CircleAvatar(
              backgroundColor: Colors.grey,
              maxRadius: 30,
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              "Ahmed Selim",
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
        toolbarHeight: 80,
        iconTheme: IconThemeData(color: Colors.black54, size: 25),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Hero(
            tag: "bg",
            child: Image.asset(
              "assets/abstract bg.jpg",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              mainBtn(
                  firstClr: HexColor("#ff8095"),
                  secondClr: HexColor("#e8c8cd"),
                  shadowClr: Colors.redAccent.withOpacity(0.5),
                  margin: EdgeInsets.fromLTRB(0, 0, 50, 25),
                  isLeft: true,
                  highlightClr: Colors.redAccent,
                  splashClr: Colors.red,
                  textMargin: EdgeInsets.fromLTRB(110, 0, 0, 0),
                  iconMargin: EdgeInsets.fromLTRB(25, 20, 0, 0),
                  icon: Image.asset("assets/dash fix.png"),
                  text: "Order an issue",
                  textStyle: TextStyle(fontSize: 25),
                  function: () {},
                  heroTag: "331"
              ),
              mainBtn(
                  firstClr: HexColor("#ebdec7"),
                  secondClr: HexColor("#edc785"),
                  shadowClr: HexColor("#d9a03d").withOpacity(0.5),
                  margin: EdgeInsets.fromLTRB(50, 15, 0, 25),
                  isLeft: false,
                  highlightClr: HexColor("#e3c468"),
                  splashClr: HexColor("#ebdec7"),
                  textMargin: EdgeInsets.fromLTRB(0, 0, 110, 0),
                  iconMargin: EdgeInsets.fromLTRB(0, 20, 25, 0),
                  icon: Image.asset("assets/dash wiat.png"),
                  text: "Pending issues",
                  textStyle: TextStyle(
                    fontSize: 25,
                  ),
                  function: () {},
                  heroTag: "3"

              ),
              mainBtn(
                  firstClr: HexColor("#7ae665"),
                  secondClr: HexColor("#c8ebc0"),
                  shadowClr: Colors.green.withOpacity(0.5),
                  margin: EdgeInsets.fromLTRB(0, 15, 50, 25),
                  isLeft: true,
                  highlightClr: HexColor("#70bf5e"),
                  splashClr: Colors.green,
                  textMargin: EdgeInsets.fromLTRB(110, 0, 0, 0),
                  iconMargin: EdgeInsets.fromLTRB(25, 20, 0, 0),
                  icon: Image.asset("assets/dash done.png"),
                  text: "Completed issues",
                  textStyle: TextStyle(fontSize: 25),
                  function: () {},
                  heroTag: "34"

              ),
              mainBtn(
                  firstClr: HexColor("#a8a5a5"),
                  secondClr: HexColor("#d6d6d6"),
                  shadowClr: Colors.black.withOpacity(0.5),
                  margin: EdgeInsets.fromLTRB(50, 15, 0, 25),
                  isLeft: false,
                  highlightClr: Colors.grey,
                  splashClr: Colors.grey,
                  textMargin: EdgeInsets.fromLTRB(0, 0, 110, 0),
                  iconMargin: EdgeInsets.fromLTRB(0, 20, 25, 0),
                  icon: Image.asset("assets/dash stats.png"),
                  text: "Statistics",
                  textStyle: TextStyle(fontSize: 25),
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Stats()),
                    );
                  },
                  heroTag: "1"
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget mainBtn({
    required Color firstClr,
    required Color secondClr,
    required Color shadowClr,
    required EdgeInsets margin,
    required bool isLeft,
    required Color highlightClr,
    required Color splashClr,
    required EdgeInsets iconMargin,
    required EdgeInsets textMargin,
    required Image icon,
    required String text,
    required TextStyle textStyle,
    required VoidCallback function,
    required String heroTag,
  }) {
    return Hero(
      tag: heroTag,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowClr,
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: isLeft
              ? BorderRadius.only(
              topRight: Radius.circular(35), bottomRight: Radius.circular(35))
              : BorderRadius.only(
              topLeft: Radius.circular(35), bottomLeft: Radius.circular(35)),
          gradient: LinearGradient(
            colors: [
              firstClr,
              secondClr,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        margin: margin,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: isLeft
                ? BorderRadius.only(
                topRight: Radius.circular(35),
                bottomRight: Radius.circular(35))
                : BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomLeft: Radius.circular(35)),
            highlightColor: highlightClr,
            splashColor: splashClr,
            onTap: function,
            child: Stack(
              children: [
                Container(
                  margin: textMargin,
                  child: Align(
                      alignment:
                      isLeft ? Alignment.centerLeft : Alignment.centerRight,
                      child: Text(
                        text,
                        style: textStyle,
                      )),
                ),
                Container(
                  margin: iconMargin,
                  padding: EdgeInsets.all(15),
                  height: 75,
                  child: Align(
                      alignment:
                      isLeft ? Alignment.centerLeft : Alignment.centerRight,
                      child: icon),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool repeat = false;
  double width = double.infinity;
  double height = 110;
}
