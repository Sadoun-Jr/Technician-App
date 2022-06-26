import 'package:flutter/material.dart';

class Technician {
  String? firstName;
  String? familyName;
  String? technicianUid;
  String? jobTitle;
  String? personalDesc; //NOT IN DATABASE
  String? image; //TODO: change to bitmap...?
  double? rating;
  bool? isAvailable;
  int? jobsCompleted;
  int? jobsDeclined;
  int? completionRate;
  int? numberOfReviews;
  int? requestAcceptanceRate;
  int? accountCreationTimeStamp;
  int? numberOfPortfolioItems;
  bool? isPreferred;
  int? phoneNumber;
  String? email;
  int? numberOfJobsPaidPhysically;
  int? numberOfJobsPaidThroughApp;
  bool? isVerifiedById;
  List? appliancesSubscribedTo;
  Map? pricesForJobIssues;
  Map? pricesForAppliancesSubscribedToIssues;
  int? numberOfFavourites;
  List? favouritedBy;
  String? location;
  int? numberOfJobsTerminatedMidWork;

  Technician.mini({
    required this.location,
    required this.firstName,
    required this.familyName,
    required this.jobTitle,
    required this.technicianUid,
    required this.personalDesc,
    required this.image,
    required this.rating,
    required this.isAvailable,});

  Technician({
      required this.firstName,
      required this.familyName,
      required this.jobTitle,
    required this.technicianUid,
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
      required this.pricesForJobIssues,
    required this.pricesForAppliancesSubscribedToIssues,
    required this.numberOfFavourites,
      required this.favouritedBy,
      required this.location,
      required this.numberOfJobsTerminatedMidWork});
}

