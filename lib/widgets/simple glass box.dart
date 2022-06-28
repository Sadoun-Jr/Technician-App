import 'dart:ui';
import 'package:flutter/material.dart';

class SimpleGlassBox extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  const SimpleGlassBox(
      {required this.height,
      required this.width,
      required this.child,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Align(
            alignment: Alignment.topCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(width: 1, color: Colors.white),
                      color: Colors.grey.shade200.withOpacity(0.25)),
                  child: Center(child: child),
                ),
              ),
            )));
  }
}
