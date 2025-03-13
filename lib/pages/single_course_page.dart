import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/models/course_model.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';
import 'package:learn_planner/widgets/custom_course_details_page_card.dart';

class SingleCoursePage extends StatelessWidget {
  final CourseModel course;
  const SingleCoursePage({super.key, required this.course});

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
          "Course Details",
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
                "assets/study.svg",
                width: 240,
                height: 240,
                fit: BoxFit.cover,
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Text(
                "Below you can see your added Course details & furthermore You can add assignments and notes and delete courses if you prefer.",
                style: AppTextStyle.kNormalTextStyle.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Divider(color: AppColors.kBlueGrey, thickness: 2),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Container(
                padding: EdgeInsets.all(AppConstance.kPaddingValue),
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
                      "Course Name:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      course.name,
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Text(
                      "Course Schedule:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      course.schedule,
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Text(
                      "Course Duration:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      course.duration,
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Text(
                      "Course Description:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      course.description,
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    Text(
                      "Course Instructor:",
                      style: AppTextStyle.kBottemLabelStyle.copyWith(
                        color: AppColors.kYellowColor,
                      ),
                    ),
                    Text(
                      course.instructor,
                      style: AppTextStyle.kNormalTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Divider(color: AppColors.kBlueGrey, thickness: 2),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).push("/add-new-assignment", extra: course);
                    },
                    child: CustomCourseDetailsPageCard(
                      imageUrl: "assets/assignment.svg",
                      name: "Add a Assignment +",
                      description:
                          "You can add any course-related Assignments by Clicking This one",
                      color: AppColors.kAssignmentCardColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push("/add-new-note", extra: course);
                    },
                    child: CustomCourseDetailsPageCard(
                      imageUrl: "assets/notebook.svg",
                      name: "Add a Note +",
                      description:
                          "You can add any course-related Notes by Clicking this one",
                      color: AppColors.kNoteCardColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
            ],
          ),
        ),
      ),
    );
  }
}
