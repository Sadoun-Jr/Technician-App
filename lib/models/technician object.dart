import 'package:flutter/material.dart';

class Technician{
  String name;
  String desc;
  Widget image; //TODO: change to bitmap...?
  String rating; //TODO: change to double
  String availability;
  //List<Review> listOfReviews
  //int jobsCompleted;
  //int

  Technician({required this.name,
    required this.desc,
    required this.image,
    required this.rating,
    required this.availability,
  });
}