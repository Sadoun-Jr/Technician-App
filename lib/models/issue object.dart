import 'package:flutter/material.dart';

class Issue {
  String issueCategory;
  String issueDesc;
  Widget image; //get it from the category, not in database
  bool isCompleted;
  String assignedTo;
  String technicianRating;
  String technicianReview;
  String timeRequested;
  String timeCompleted;
  String paymentMethod;
  double price;
  // String issueUid;
  // bool isEmergency;
  // bool isPaid;
  // String issuedBy;
  // String isAcceptedByTechnician;
  // bool isCanceledByUser;
  // bool isDeclinedByTechnician;
  // bool isCustomIssue;
  // String issuedBy;

  Issue({
    required this.issueCategory,
    required this.issueDesc,
    required this.image,
    required this.technicianRating,
    required this.isCompleted,
    required this.assignedTo,
    required this.paymentMethod,
    required this.timeCompleted,
    required this.timeRequested,
    required this.technicianReview,
    required this.price,
  });
}
