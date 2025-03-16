import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';

class LearnerProfilePage extends StatefulWidget {
  const LearnerProfilePage({super.key});

  @override
  State<LearnerProfilePage> createState() => _LearnerProfilePageState();
}

class _LearnerProfilePageState extends State<LearnerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learner Profile", style: AppTextStyle.kMainTitleStyle),
        actions: [
          SizedBox(width: AppConstance.kSizedBoxValue * 3),
          IconButton(
            onPressed: () {
              GoRouter.of(context).push("/notification-page");
            },
            icon: Icon(
              Icons.notifications,
              size: 35,
              color: AppColors.kAssignmentCardColor1,
            ),
          ),
          SizedBox(width: AppConstance.kSizedBoxValue),
        ],
        centerTitle: true,
      ),
    );
  }
}
