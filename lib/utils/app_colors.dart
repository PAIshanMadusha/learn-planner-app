import 'package:flutter/material.dart';

class AppColors {
  static const Color kBlueGrey = Color.fromARGB(255, 171, 211, 233);
  static const Color kBlackColor = Colors.black;
  static const Color kWhiteColor = Colors.white;
  static const Color kRedAccentColor = Colors.redAccent;

  static const Color kCourseCardColor1 = Color.fromARGB(255, 200, 255, 248);
  static const Color kYellowColor = Colors.yellowAccent;

  static const Gradient kCourseCardColor = LinearGradient(
    colors: [kCourseCardColor1, kYellowColor],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color kAssignmentCardColor1 = Color(0xffE6B2BA);
  static const Color kAssignmentCardColor2 = Color(0xffC599B6);

  static const Gradient kAssignmentCardColor = LinearGradient(
    colors: [kAssignmentCardColor1, kAssignmentCardColor2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color kNoteCardColor1 = Color(0xffFF8989);
  static const Color kNotetCardColor2 = Color(0xffF8ED8C);

  static const Gradient kNoteCardColor = LinearGradient(
    colors: [kNoteCardColor1, kNotetCardColor2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
