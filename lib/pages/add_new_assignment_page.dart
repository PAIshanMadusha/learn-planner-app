import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/helpers/app_helpers.dart';
import 'package:learn_planner/models/assignment_model.dart';
import 'package:learn_planner/models/course_model.dart';
import 'package:learn_planner/services/firestore_database/assignment_service.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';
import 'package:learn_planner/widgets/custom_button.dart';
import 'package:learn_planner/widgets/custom_input_field.dart';

class AddNewAssignmentPage extends StatelessWidget {
  final CourseModel course;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _assignmentSubjectController =
      TextEditingController();
  final TextEditingController _assignmentNameController =
      TextEditingController();
  final TextEditingController _assignmentDurationController =
      TextEditingController();
  final TextEditingController _assignmentDescriptionController =
      TextEditingController();

  final ValueNotifier<DateTime> _selectStartDate = ValueNotifier<DateTime>(
    DateTime.now(),
  );
  final ValueNotifier<DateTime> _selectDate = ValueNotifier<DateTime>(
    DateTime.now(),
  );
  final ValueNotifier<TimeOfDay> _selectTime = ValueNotifier<TimeOfDay>(
    TimeOfDay.now(),
  );

  //Initialize ValueNotifiers
  AddNewAssignmentPage({super.key, required this.course}) {
    _selectStartDate.value = DateTime.now();
    _selectDate.value = DateTime.now();
    _selectTime.value = TimeOfDay.now();
  }

  //Date Picker
  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      initialDate: _selectDate.value,
    );
    if (pickedDate != null && pickedDate != _selectDate.value) {
      _selectDate.value = pickedDate;
    }
  }

  //Time Picker
  Future<void> _selectedTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectTime.value,
    );
    if (pickedTime != null && pickedTime != _selectTime.value) {
      _selectTime.value = pickedTime;
    }
  }

  //Add Assignment
  void _addAssignment(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        //Create a New Assignment
        final AssignmentModel assignment = AssignmentModel(
          id: "",
          subject: _assignmentSubjectController.text,
          name: _assignmentNameController.text,
          duration: _assignmentDurationController.text,
          description: _assignmentDescriptionController.text,
          startDate: _selectStartDate.value,
          dueDate: _selectDate.value,
          dueTime: _selectTime.value,
        );
        //Add Assignment to Database
        AssignmentService().createAssignment(course.id, assignment);

        AppHelpers.showSnackBar(context, "Assignment Added Successfully!");

        await Future.delayed(Duration(seconds: 1));

        if (context.mounted) {
          GoRouter.of(context).pop();
        }
      } catch (error) {
        if (context.mounted) {
          AppHelpers.showSnackBar(context, "Faild to Add Assignment!");
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
          "Add a New Assignment",
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
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/assignment.svg",
                width: 180,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Text(
                "Fill in the details below and add a new assignment related to your course and start managing your learn planner.",
                style: AppTextStyle.kNormalTextStyle.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Divider(color: AppColors.kBlueGrey, thickness: 1),
              SizedBox(height: AppConstance.kSizedBoxValue),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomInputField(
                      controller: _assignmentSubjectController,
                      labelText: "Assignment Subject",
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please Enter Assignment Subject";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    CustomInputField(
                      controller: _assignmentNameController,
                      labelText: "Assignment Name",
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please Enter a Assignment Name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    CustomInputField(
                      controller: _assignmentDurationController,
                      labelText: "Assignment Duration",
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please Enter Assignment Duration";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    CustomInputField(
                      controller: _assignmentDescriptionController,
                      labelText: "Assignment Description",
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Please Enter a Assignment Description";
                        }
                        return null;
                      },
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
                        children: [
                          Text(
                            "Select Date & Time",
                            style: AppTextStyle.kNormalTextStyle.copyWith(
                              color: AppColors.kYellowColor,
                            ),
                          ),
                          SizedBox(height: AppConstance.kSizedBoxValue),
                          ValueListenableBuilder<DateTime>(
                            valueListenable: _selectDate,
                            builder: (context, date, child) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Start Date: ${date.toLocal().toString().split(" ")[0]}",
                                      style: AppTextStyle.kNormalTextStyle
                                          .copyWith(fontSize: 22),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      side: WidgetStatePropertyAll(
                                        BorderSide(
                                          color: AppColors.kWhiteColor,
                                        ),
                                      ),
                                      backgroundColor: WidgetStatePropertyAll(
                                        AppColors.kBlueGrey,
                                      ),
                                    ),
                                    onPressed: () => _selectedDate(context),
                                    label: Text(
                                      "Select",
                                      style: AppTextStyle.kBottemLabelStyle
                                          .copyWith(
                                            color: AppColors.kBlackColor,
                                          ),
                                    ),
                                    icon: Icon(
                                      Icons.calendar_month_outlined,
                                      size: 26,
                                      color: AppColors.kBlackColor,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: AppConstance.kSizedBoxValue),
                          ValueListenableBuilder<DateTime>(
                            valueListenable: _selectDate,
                            builder: (context, date, child) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Due Date: ${date.toLocal().toString().split(" ")[0]}",
                                      style: AppTextStyle.kNormalTextStyle
                                          .copyWith(fontSize: 21),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      side: WidgetStatePropertyAll(
                                        BorderSide(
                                          color: AppColors.kWhiteColor,
                                        ),
                                      ),
                                      backgroundColor: WidgetStatePropertyAll(
                                        AppColors.kBlueGrey,
                                      ),
                                    ),
                                    onPressed: () => _selectedDate(context),
                                    label: Text(
                                      "Select",
                                      style: AppTextStyle.kBottemLabelStyle
                                          .copyWith(
                                            color: AppColors.kBlackColor,
                                          ),
                                    ),
                                    icon: Icon(
                                      Icons.calendar_month_outlined,
                                      size: 26,
                                      color: AppColors.kBlackColor,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: AppConstance.kSizedBoxValue),
                          ValueListenableBuilder(
                            valueListenable: _selectTime,
                            builder: (context, time, child) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Ending Time: ${time.format(context)}",
                                      style: AppTextStyle.kNormalTextStyle
                                          .copyWith(fontSize: 21),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      side: WidgetStatePropertyAll(
                                        BorderSide(
                                          color: AppColors.kWhiteColor,
                                        ),
                                      ),
                                      backgroundColor: WidgetStatePropertyAll(
                                        AppColors.kBlueGrey,
                                      ),
                                    ),
                                    onPressed: () => _selectedTime(context),
                                    label: Text(
                                      "Select",
                                      style: AppTextStyle.kBottemLabelStyle
                                          .copyWith(
                                            color: AppColors.kBlackColor,
                                          ),
                                    ),
                                    icon: Icon(
                                      Icons.access_time_outlined,
                                      size: 26,
                                      color: AppColors.kBlackColor,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue * 2),
                    CustomButton(
                      textLabel: "Add Assignment",
                      icon: Icons.add_task_sharp,
                      onPressed: () => _addAssignment(context),
                    ),
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
