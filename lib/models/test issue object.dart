import 'package:flutter/material.dart';

class TestIssue {
  String? issueCategory;
  String? issueDesc;
  bool? isCompleted;
  double? technicianRating; //todo: change to double, its int for -1 ratings in test db
  String? technicianReview;
  int? timeRequested;
  int? timeCompleted;
  String? paymentMethod;
  double? price; //todo: change to double, its int for -1 ratings in test db
  String? issueUid;
  bool? isEmergency;
  bool? isPaid;
  String? issuedBy;
  String? issuedTo;
  bool? isAcceptedByTechnician;
  bool? isCanceledByUser;
  List? listOfImages;
  //todo: add isTerminatedMidWork

  TestIssue(
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
      required this.issuedTo,
      required this.isAcceptedByTechnician,
      required this.isCanceledByUser,
        required this.listOfImages,
      });
}
