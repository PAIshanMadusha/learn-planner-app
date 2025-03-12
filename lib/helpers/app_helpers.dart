import 'package:flutter/material.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_text_style.dart';

class AppHelpers {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kYellowColor,
        content: Text(
          message,
          style: AppTextStyle.kNormalTextStyle.copyWith(
            fontSize: 15,
            color: AppColors.kBlackColor,
          ),
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
