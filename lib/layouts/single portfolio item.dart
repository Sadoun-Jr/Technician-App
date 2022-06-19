import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
class SinglePortfolioItem extends StatefulWidget {
  final dynamic selectedImage;
  const SinglePortfolioItem(this.selectedImage, {Key? key}) : super(key: key);

  @override
  State<SinglePortfolioItem> createState() => _SinglePortfolioItemState();
}

class _SinglePortfolioItemState extends State<SinglePortfolioItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Hero(
          tag: widget.selectedImage,
          child: Image.file(
            File(widget.selectedImage),
            width: double.infinity,
            height: double.infinity,
          )
        ),
      ),
    );
  }
}

