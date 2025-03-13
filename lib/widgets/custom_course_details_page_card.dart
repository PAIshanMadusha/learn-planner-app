import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';

class CustomCourseDetailsPageCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final Gradient color;
  const CustomCourseDetailsPageCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstance.kPaddingValue),
      width: MediaQuery.of(context).size.width * 0.446,
      height: MediaQuery.of(context).size.height * 0.29,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstance.kRoundCornerValue),
        gradient: color,
        boxShadow: [
          BoxShadow(
            color: AppColors.kWhiteColor,
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            imageUrl,
            width: 200,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: AppConstance.kSizedBoxValue),
          Text(
            name,
            style: AppTextStyle.kNormalTextStyle.copyWith(
              color: AppColors.kBlackColor,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppConstance.kSizedBoxValue),
          Text(
            description,
            style: AppTextStyle.kNormalTextStyle.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
