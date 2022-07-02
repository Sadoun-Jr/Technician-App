import 'package:flutter/material.dart';

class Consumer {
  String? firstName;
  String? familyName;
  String? userUid;
  int? jobsPaidPhysically;
  int? jobsPaidThroughApp;
  String? profilePicUrl;
  Widget? image; //TODO: change to bitmap...?
  int? numberOfReviews;
  int? accountCreationTimeStamp;
  String? phoneNumber;
  String? email;
  bool? isVerifiedById;
  int? numberOfFavourites;
  String? location;
  String? subLocation;
  int? age;
  List? listOfFavourites;
  //String gender;

  Consumer({
     required this.firstName,
    required this.familyName,
    required this.userUid,
    required this.image,
    required this.numberOfReviews,
    required this.jobsPaidPhysically,
    required this.jobsPaidThroughApp,
    required this.accountCreationTimeStamp,
    required this.phoneNumber,
    required this.email,
    required this.isVerifiedById,
    required this.subLocation,
    required this.profilePicUrl,
    required this.age,
    required this.numberOfFavourites,
    required this.location});
}
