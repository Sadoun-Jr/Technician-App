import 'package:flutter/material.dart';

class Technician {
  String? firstName;  //TODO: change to firstName
  String? familyName;
  String? jobTitle;
  String? personalDesc; //NOT IN DATABASE
  Widget? image; //TODO: change to bitmap...?
  double? rating; //TODO: change to double
  bool isAvailable;
  int? jobsCompleted;
  int? jobsDeclined;
  int? completionRate;
  int? numberOfReviews;
  int? requestAcceptanceRate;
  int? accountCreationTimeStamp;
  int? numberOfPortfolioItems;
  bool isPreferred;
  int? phoneNumber;
  String? email;
  int? numberOfJobsPaidPhysically;
  int? numberOfJobsPaidThroughApp;
  bool isVerifiedById;
  List? appliancesSubscribedTo;
  Map? pricesForCommonIssues;
  int? numberOfFavourites;
  List? favouritedBy;
  String? location;
  int? numberOfJobsTerminatedMidWork;

  Technician({
      required this.firstName,
      required this.familyName,
      required this.jobTitle,
      required this.personalDesc,
      required this.image,
      required this.rating,
      required this.isAvailable,
      required this.jobsCompleted,
      required this.jobsDeclined,
      required this.completionRate,
      required this.numberOfReviews,
      required this.requestAcceptanceRate,
      required this.accountCreationTimeStamp,
      required this.numberOfPortfolioItems,
      required this.isPreferred,
      required this.phoneNumber,
      required this.email,
      required this.numberOfJobsPaidPhysically,
      required this.numberOfJobsPaidThroughApp,
      required this.isVerifiedById,
      required this.appliancesSubscribedTo,
      required this.pricesForCommonIssues,
      required this.numberOfFavourites,
      required this.favouritedBy,
      required this.location,
      required this.numberOfJobsTerminatedMidWork});
}
