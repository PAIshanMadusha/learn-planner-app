import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_planner/utils/app_colors.dart';

class ThemesModeData {
  //Drak Mode
  final ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.poppins().fontFamily,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
     bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.kBlackColor,
      selectedItemColor: AppColors.kBlueGrey,
      unselectedItemColor: AppColors.kYellowColor,
    ),
  );

  //Light Mode
  final ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.kWhiteColor,
      selectedItemColor: AppColors.kBlueGrey,
      unselectedItemColor: AppColors.kBlueColor,
    ),
  );
}
