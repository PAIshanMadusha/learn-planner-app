import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstance.kPaddingValue),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Lottie.asset(
                      "assets/animations/Animation1.json",
                      width: 170,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      "Learn Planner",
                      style: AppTextStyle.kMainTitleStyle,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
                Text(
                  "Your Learn Planner app helps you to keep track of education progress and manage your time efficiently.",
                  style: AppTextStyle.kNormalTextStyle.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      AppColors.kYellowColor,
                    ),
                  ),
                  onPressed: () {
                    GoRouter.of(context).push("/add-new-course");
                  },
                  label: Text(
                    "Add a Course",
                    style: AppTextStyle.kNormalTextStyle.copyWith(
                      color: AppColors.kBlackColor,
                    ),
                  ),
                  icon: Icon(Icons.add, size: 28
                  , color: AppColors.kBlackColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
