import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/helpers/app_helpers.dart';
import 'package:learn_planner/models/course_model.dart';
import 'package:learn_planner/services/course_service.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';
import 'package:learn_planner/widgets/custom_button.dart';
import 'package:learn_planner/widgets/custom_input_field.dart';

class AddNewCourse extends StatelessWidget {
  AddNewCourse({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController =
      TextEditingController();
  final TextEditingController _courseDurationController =
      TextEditingController();
  final TextEditingController _courseScheduleController =
      TextEditingController();
  final TextEditingController _courseInstructorController =
      TextEditingController();

  void _submitCourse(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      //Save the Form
      _formKey.currentState?.save();
      try {
        final CourseModel course = CourseModel(
          id: "",
          name: _courseNameController.text,
          description: _courseDescriptionController.text,
          duration: _courseDurationController.text,
          schedule: _courseScheduleController.text,
          instructor: _courseInstructorController.text,
        );
        await CourseService().createNewCourse(course);
        if (context.mounted) {
          AppHelpers.showSnackBar(context, "Course Added Successfully!");
        }
        
        await Future.delayed(Duration(seconds: 2));

        if(context.mounted){
          GoRouter.of(context).go("/");
        }
      } catch (error) {
        if (context.mounted) {
          AppHelpers.showSnackBar(context, "Faild to Add Course!");
        }
      }
    }
  }
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
          "Add a New Course",
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
          child: Form(
            key: _formKey,
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
                  "Fill in the course details to add a new course and start managing your study plan effectively. Keep track of your studies, stay organized, and plan your learning journey with ease.",
                  style: AppTextStyle.kNormalTextStyle.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
                CustomInputField(
                  controller: _courseNameController,
                  labelText: "Course Name",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please Enter a Course Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
                CustomInputField(
                  controller: _courseDescriptionController,
                  labelText: "Course Description",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please Enter a Course Description";
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
                CustomInputField(
                  controller: _courseDurationController,
                  labelText: "Course Duration",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please Enter the Course Duration";
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
                CustomInputField(
                  controller: _courseScheduleController,
                  labelText: "Course Schedule",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please Enter the Course Schedule";
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
                CustomInputField(
                  controller: _courseInstructorController,
                  labelText: "Course Instructor",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please Enter the Course Instructor";
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppConstance.kSizedBoxValue * 2),
                CustomButton(
                  textLabel: "Add Course",
                  icon: Icons.add_task_sharp,
                  onPressed: () {
                    _submitCourse(context);
                  },
                ),
                SizedBox(height: AppConstance.kSizedBoxValue),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
