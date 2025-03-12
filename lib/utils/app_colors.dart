import 'package:flutter/material.dart';

class AppColors {
  static const Color kBlueGrey = Color.fromARGB(255, 171, 211, 233);
  static const Color kYellowColor = Colors.yellowAccent;
  static const Color kBlackColor = Colors.black;
  static const Color kWhiteColor = Colors.white;
  static const Color kRedAccentColor = Colors.redAccent;

  static const Color kCourseCardColor1 = Color.fromARGB(255, 216, 255, 250);
  static const Color kCourseCardColor2 = Color.fromARGB(255, 253, 255, 126);

  static const Gradient kCourseCardColor = LinearGradient(
    colors: [kCourseCardColor1, kCourseCardColor2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
