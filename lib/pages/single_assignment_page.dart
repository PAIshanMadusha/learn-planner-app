import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:learn_planner/models/assignment_model.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';

class SingleAssignmentPage extends StatelessWidget {
  final AssignmentModel assignment;
  const SingleAssignmentPage({super.key, required this.assignment});

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
          "Your Assignment Details",
          style: AppTextStyle.kMainTitleStyle.copyWith(
            fontSize: 28,
            color: AppColors.kYellowColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppConstance.kPaddingValue),
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/assignment.svg",
                width: 180,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Divider(color: AppColors.kBlueGrey, thickness: 1),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Container(
                padding: EdgeInsets.all(AppConstance.kPaddingValue),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppConstance.kRoundCornerValue,
                  ),
                  // ignore: deprecated_member_use
                  color: AppColors.kBlueGrey.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: AppColors.kBlackColor.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assignment Name:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      assignment.name,
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Text(
                      "Assignment Subject:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      assignment.subject,
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Text(
                      "Assignment Duration:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      assignment.duration,
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Text(
                      "Assignment Due Date:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMd().format(assignment.dueDate),
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Text(
                      "Assignment Time:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      DateFormat.Hm().format(
                        DateTime(
                          0,
                          0,
                          0,
                          assignment.dueTime.hour,
                          assignment.dueTime.minute,
                        ),
                      ),
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Text(
                      "Assignment Description:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      assignment.description,
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
