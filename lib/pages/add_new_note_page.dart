import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/models/course_model.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_text_style.dart';

class AddNewNotePage extends StatelessWidget {
  final CourseModel course;
  const AddNewNotePage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 35,
            color: AppColors.kYellowColor,
          ),
        ),
        title: Text(
          "Add a New Note",
          style: AppTextStyle.kMainTitleStyle.copyWith(
            fontSize: 28,
            color: AppColors.kYellowColor,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
