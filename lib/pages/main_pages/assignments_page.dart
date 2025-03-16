import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:learn_planner/models/assignment_model.dart';
import 'package:learn_planner/services/firestore_database/assignment_service.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';
import 'package:learn_planner/widgets/countdown_timer.dart';

class AssignmentsPage extends StatelessWidget {
  const AssignmentsPage({super.key});

  Future<Map<String, List<AssignmentModel>>> _fetchAssignment() async {
    return await AssignmentService().getAssignmentsByCourseName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assignments Page", style: AppTextStyle.kMainTitleStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstance.kPaddingValue),
        child: FutureBuilder(
          future: _fetchAssignment(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.kYellowColor),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: AppConstance.kSizedBoxValue * 8),
                    SvgPicture.asset(
                      "assets/emptydatapic.svg",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: AppConstance.kSizedBoxValue),
                    SizedBox(
                      width: 280,
                      child: Text(
                        "No Assignments are available!",
                        style: AppTextStyle.kLabelTextStyle.copyWith(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            }
            final assignmentMap = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.only(bottom: AppConstance.kPaddingValue * 2),
              itemCount: assignmentMap.keys.length,
              itemBuilder: (context, index) {
                final courseName = assignmentMap.keys.elementAt(index);
                final assignments = assignmentMap[courseName]!;
                return ExpansionTile(
                  leading: Icon(
                    Icons.task,
                    size: 30,
                    color: AppColors.kYellowColor,
                  ),
                  iconColor: AppColors.kYellowColor,
                  title: Text(
                    courseName.toUpperCase(),
                    style: AppTextStyle.kNormalTextStyle.copyWith(
                      fontSize: 21,
                      color: AppColors.kWhiteColor,
                    ),
                  ),
                  children:
                      assignments.map((assignment) {
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: AppConstance.kPaddingValue,
                          ),
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
                              CountdownTimer(dueDate: assignment.dueDate),
                            ],
                          ),
                        );
                      }).toList(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
