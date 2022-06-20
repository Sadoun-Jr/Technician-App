import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class TestUI extends StatefulWidget {
  final int tagIndex;
  const TestUI(this.tagIndex, {Key? key}) : super(key: key);

  @override
  State<TestUI> createState() => _TestUIState();
}

class _TestUIState extends State<TestUI> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Hero(
          tag: widget.tagIndex,
          child: Card(
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
                      "Gary Muller",
                      maxLines: 1,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),
                  InkWell(onTap: () {},
                      child: LikeButton()),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Painter",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "a short desc", //TODO: add in db
                        maxLines: 2,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
