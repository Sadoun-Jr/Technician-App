import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double width, height;

  const Logo(this.height,
      this.width,{Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
        height: 100,
        width: double.infinity,
        child: Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            decoration:
            BoxDecoration(color: Colors.transparent,
                border: Border.all(color: Colors.white.withOpacity(0.2),
                    width: 5.0),
                shape: BoxShape.circle
            ),
            child: Icon(Icons.timer, size: 75,)
        ),
      );
    }
}
