import 'package:flutter/material.dart';

class Review {
  String? issueTitle;
  String? issueDesc;
  bool? isLeftMidWork;
  String? rating;
  String? reviewDesc;
  int? timeOfReview;
  String? paymentMethod;
  dynamic price;
  String? issueUid;
  String? issuedBy;
  String? issuedTo;

  //v2, don't implement during first
  //String timeModified;
  //String modificationReason

  Review(
      {required this.issueTitle,
      required this.issueDesc,
      required this.isLeftMidWork,
      required this.rating,
      required this.reviewDesc,
      required this.timeOfReview,
      required this.paymentMethod,
      required this.price,
      required this.issueUid,
      required this.issuedTo,
      required this.issuedBy});
}
