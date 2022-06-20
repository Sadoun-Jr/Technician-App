import 'package:flutter/material.dart';

class Portfolio {
  String?       portfolioUid;
  String?       title;
  String?       desc;
  String?       issuedBy;
  int?          dateAdded;
  int?          numberOfViews;
  int?          numberOfPictures;
  int?          numberOfFavourites;
  List?         listOfImagePaths;

  Portfolio(
      { required this.title,
        required this.desc,
        required this.issuedBy,
        required this.dateAdded,
        required this.numberOfViews,
        required this.numberOfPictures,
        required this.numberOfFavourites,
        required this.listOfImagePaths,
        required this.portfolioUid,
        });
}
