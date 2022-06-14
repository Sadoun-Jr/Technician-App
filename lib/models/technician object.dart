import 'package:flutter/material.dart';

class Technician{
  String name;
  String desc;
  Widget image;
  String rating;
  String availability;
  //List<Review>; listOfReviews

  Technician({required this.name,
    required this.desc,
    required this.image,
    required this.rating,
    required this.availability,
  });
}