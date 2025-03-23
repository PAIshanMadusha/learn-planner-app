import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/helpers/app_helpers.dart';
import 'package:learn_planner/models/course_model.dart';
import 'package:learn_planner/services/firestore_database/course_service.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';
import 'package:learn_planner/widgets/custom_button.dart';
import 'package:learn_planner/widgets/custom_input_field.dart';

class AddNewCoursePage extends StatefulWidget {
  final CourseModel? courseToEdit;
  const AddNewCoursePage({super.key, this.courseToEdit});

  @override
  State<AddNewCoursePage> createState() => _AddNewCoursePageState();
}

class _AddNewCoursePageState extends State<AddNewCoursePage> {
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

  @override
  void initState() {
    super.initState();
    if (widget.courseToEdit != null) {
      // Populate fields for editing
      _courseNameController.text = widget.courseToEdit!.name;
      _courseDescriptionController.text = widget.courseToEdit!.description;
      _courseDurationController.text = widget.courseToEdit!.duration;
      _courseScheduleController.text = widget.courseToEdit!.schedule;
      _courseInstructorController.text = widget.courseToEdit!.instructor;
    }
  }

  void _submitCourse(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      try {
        final CourseModel course = CourseModel(
          id: widget.courseToEdit?.id ?? "", // Use existing ID if editing
          name: _courseNameController.text,
          description: _courseDescriptionController.text,
          duration: _courseDurationController.text,
          schedule: _courseScheduleController.text,
          instructor: _courseInstructorController.text,
        );

        if (widget.courseToEdit == null) {
          await CourseService().createNewCourse(course);
          if (context.mounted) {
            AppHelpers.showSnackBar(context, "Course Added Successfully!");
          }
        } else {
          await CourseService().updateCourse(course);
          if (context.mounted) {
            AppHelpers.showSnackBar(context, "Course Updated Successfully!");
          }
        }

        await Future.delayed(Duration(seconds: 1));

        // Navigate back to the course page with refresh
        if (context.mounted) {
          GoRouter.of(context).pop(true);
        }
      } catch (error) {
        if (context.mounted) {
          AppHelpers.showSnackBar(context, "Failed to Save Course!");
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
            color: AppColors.kBlueGrey,
          ),
        ),
        title: Text(
          widget.courseToEdit == null ? "Add a New Course" : "Update Course",
          style: AppTextStyle.kMainTitleStyle.copyWith(
            fontSize: 28,
            color: AppColors.kBlueGrey,
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
                  textLabel:
                      widget.courseToEdit == null
                          ? "Add Course"
                          : "Update Course",
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
