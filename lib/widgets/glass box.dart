import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassBox extends StatelessWidget {
  final double width, height;
  final Widget child;

  const FrostedGlassBox(this.height,
      this.width,this.child,{Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 7.0,
                sigmaY: 7.0,
              ),
              child: Container(width: width, height: height, child: Text(" ")),
            ),
            // Opacity(
            //     opacity: 0.15,
            //     child: Image.asset(
            //       "assets/noise.png",
            //       fit: BoxFit.cover,
            //       width: width,
            //       height: height,
            //     )),
            Container(
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.15),
                      blurRadius: 30, offset: Offset(2, 2))],
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(color: Colors.white,
                      width: 3.0),
                  gradient: LinearGradient(begin: Alignment.topLeft,
                      end: Alignment.bottomRight, colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.1),
                  ], stops: const [
                    0.0,
                    1.0,
                  ])),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
