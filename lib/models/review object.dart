import 'package:flutter/material.dart';

class Review{
  String issueTitle;
  String issueDesc;
  bool isLeftMidWork;
  String rating;
  String reviewDesc;
  String timeOfReview;
  String paymentMethod;
  double price;
  int issueNumber;
  String reviewGiver;

  //v2, don't implement during first
  //String timeModified;
  //String modificationReason

  Review({
  required  this.issueTitle,
  required this.issueDesc,
  required  this.isLeftMidWork,
  required  this.rating,
  required  this.reviewDesc,
  required  this.timeOfReview,
  required  this.paymentMethod,
  required  this.price,
  required  this.issueNumber,
  required  this.reviewGiver
});

}