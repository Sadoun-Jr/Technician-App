import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

Widget slider () {
  var sliderSleek = SleekCircularSlider(
      appearance: CircularSliderAppearance(

        size: 50,
        customColors: CustomSliderColors(
            trackColor: Colors.blue,
            progressBarColor: Colors.blue
        ) ,
        spinnerMode: true,
      ));
  return sliderSleek;
}