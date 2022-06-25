import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget circleBtn(String image, String text, Color? spalshClr, String tag) {
  return Hero(
    tag: tag,
    child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Align(
            alignment: Alignment.topCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(150)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: spalshClr,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Stats()),
                      // );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(100)),
                          border: Border.all(width: 1, color: Colors.white54),
                          color: Colors.grey.shade200.withOpacity(0.25)),
                      child: Center(
                          child: Align(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  image,
                                  height: 40,
                                  width: 40,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    text,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ))),
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
            topRight: Radius.circular(35),
            bottomRight: Radius.circular(35))
            : BorderRadius.only(
            topLeft: Radius.circular(35),
            bottomLeft: Radius.circular(35)),
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