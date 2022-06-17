import 'package:flutter/material.dart';

class Issue {
  String issueCategory;
  String issueDesc;
  bool isCompleted;
  double technicianRating;
  String technicianReview;
  int timeRequested;
  int timeCompleted;
  String paymentMethod;
  double price;
  String issueUid;
  bool isEmergency;
  bool isPaid;
  String issuedBy;
  bool isAcceptedByTechnician;
  bool isCanceledByUser;
  bool isTerminatedMidWork;
  String issuedTo;

  Issue(
      {required this.issueCategory,
        required this.issueDesc,
        required this.isCompleted,
        required this.technicianRating,
        required this.technicianReview,
        required this.timeRequested,
        required this.timeCompleted,
        required this.paymentMethod,
        required this.price,
        required this.issueUid,
        required this.isEmergency,
        required this.isPaid,
        required this.issuedBy,
        required this.isAcceptedByTechnician,
        required this.isCanceledByUser,
        required this.issuedTo,
        required this.isTerminatedMidWork
      });
}
