import 'package:flutter/material.dart';

class AppColors {
  static const Color kBlueGrey = Color.fromARGB(255, 171, 211, 233);
  static const Color kBlackColor = Colors.black;
  static const Color kWhiteColor = Colors.white;
  static const Color kRedAccentColor = Colors.redAccent;
    static const Color kYellowColor = Colors.yellowAccent;

  static const Color kCourseCardColor1 = Color(0xff4379F2);
  static const Color kCourseCardColor2 = Color(0xffFFEB00);

  static const Gradient kCourseCardColor = LinearGradient(
    colors: [kCourseCardColor1, kCourseCardColor2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color kAssignmentCardColor1 = Color(0xff693382);
  static const Color kAssignmentCardColor2 = Color(0xff336D82);

  static const Gradient kAssignmentCardColor = LinearGradient(
    colors: [kAssignmentCardColor1, kAssignmentCardColor2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color kNoteCardColor1 = Color(0xff9F5255);
  static const Color kNotetCardColor2 = Color(0xffE16A54);

  static const Gradient kNoteCardColor = LinearGradient(
    colors: [kNoteCardColor1, kNotetCardColor2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color kProfileCardColor1 = Color(0xffC07F00);
  static const Color kProfileCardColor2 = Color(0xff4C3D3D);

  static const Gradient kProfileCardColor = LinearGradient(
    colors: [kProfileCardColor1, kProfileCardColor2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
