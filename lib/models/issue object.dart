import 'package:flutter/material.dart';

class Issue{
  String issueTitle;
  String issueDesc;
  Widget image;
  bool isCompleted;
  String completedBy;
  String technicianRating;
  String technicianReview;
  String timeRequested;
  String timeCompleted;
  String paymentMethod;
  double price;

  Issue({
    required this.issueTitle,
    required this.issueDesc,
    required this.image,
    required this.technicianRating,
    required this.isCompleted,
    required this.completedBy,
    required this.paymentMethod,
    required this.timeCompleted,
    required this.timeRequested,
    required this.technicianReview,
    required this.price,

  });
}