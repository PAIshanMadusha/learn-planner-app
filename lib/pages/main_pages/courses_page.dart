import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/models/assignment_model.dart';
import 'package:learn_planner/models/course_model.dart';
import 'package:learn_planner/models/note_model.dart';
import 'package:learn_planner/services/firestore_database/assignment_service.dart';
import 'package:learn_planner/services/firestore_database/course_service.dart';
import 'package:learn_planner/services/firestore_database/note_service.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';
import 'package:intl/intl.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  Future<Map<String, dynamic>> _fetchAllData() async {
    try {
      final courses = await CourseService().getCourse();
      final assignmentsMap =
          await AssignmentService().getAssignmentsByCourseName();
      final notesMap = await NoteService().getNotesByCourseName();
      return {
        "courses": courses,
        "assignments": assignmentsMap,
        "notes": notesMap,
      };
    } catch (error) {
      debugPrint("Error: $error");
      return {"courses": [], "assignments": {}, "notes": {}};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses Page", style: AppTextStyle.kMainTitleStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstance.kPaddingValue),
        child: FutureBuilder(
          future: _fetchAllData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.kYellowColor),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data == null) {
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
                        "No courses are available! You can add courses by clicking the add a course button.",
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
            final courses =
                snapshot.data!["courses"] as List<CourseModel>? ?? [];
            final assignmentsMap =
                snapshot.data!["assignments"]
                    as Map<String, List<AssignmentModel>>? ??
                {};
            final notesMap =
                snapshot.data!["notes"] as Map<String, List<NoteModel>>? ?? {};
            if (courses.isEmpty) {
              return Center(
                child: Text(
                  "No courses are available! You can add courses by clicking the add a course button.",
                  style: AppTextStyle.kLabelTextStyle.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                final courseAssignments = assignmentsMap[course.name] ?? [];
                final courseNotes = notesMap[course.name] ?? [];

                return Container(
                  margin: EdgeInsets.only(bottom: AppConstance.kPaddingValue),
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
                      Center(
                        child: SvgPicture.asset(
                          "assets/study.svg",
                          width: 240,
                          height: 240,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      Center(
                        child: Text(
                          course.name.toUpperCase(),
                          style: AppTextStyle.kNormalTextStyle.copyWith(
                            fontSize: 21,
                            color: AppColors.kWhiteColor,
                          ),
                          textAlign: TextAlign.center,
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
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      if (courseAssignments.isNotEmpty) ...[
                        Center(
                          child: Text(
                            "ASSIGNMENTS",
                            style: AppTextStyle.kNormalTextStyle.copyWith(
                              fontSize: 21,
                              color: AppColors.kWhiteColor,
                            ),
                          ),
                        ),
                        SizedBox(height: AppConstance.kSizedBoxValue),
                        Column(
                          children:
                              courseAssignments.map((assignment) {
                                return Container(
                                  padding: EdgeInsets.all(
                                    AppConstance.kPaddingValue,
                                  ),
                                  margin: EdgeInsets.only(
                                    bottom: AppConstance.kPaddingValue,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      AppConstance.kRoundCornerValue,
                                    ),
                                    gradient: AppColors.kAssignmentCardColor,
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      GoRouter.of(context).push(
                                        "/single-assignment",
                                        extra: assignment,
                                      );
                                    },
                                    leading: Icon(
                                      Icons.task,
                                      size: 30,
                                      color: AppColors.kBlueGrey,
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Name: ",
                                          style: AppTextStyle.kBottemLabelStyle
                                              .copyWith(
                                                color: AppColors.kYellowColor,
                                              ),
                                        ),
                                        Text(
                                          assignment.name,
                                          style: AppTextStyle.kNormalTextStyle
                                              .copyWith(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Subject: ",
                                          style: AppTextStyle.kBottemLabelStyle
                                              .copyWith(
                                                color: AppColors.kYellowColor,
                                              ),
                                        ),
                                        Text(
                                          assignment.subject,
                                          style: AppTextStyle.kBottemLabelStyle
                                              .copyWith(
                                                color: AppColors.kBlueGrey,
                                              ),
                                        ),
                                        Text(
                                          "Due Date: ",
                                          style: AppTextStyle.kBottemLabelStyle
                                              .copyWith(
                                                color: AppColors.kYellowColor,
                                              ),
                                        ),
                                        Text(
                                          DateFormat.yMMMd().format(
                                            assignment.dueDate,
                                          ),
                                          style: AppTextStyle.kBottemLabelStyle
                                              .copyWith(
                                                color: AppColors.kBlueGrey,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ],
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      if (courseNotes.isNotEmpty) ...[
                        Center(
                          child: Text(
                            "NOTES",
                            style: AppTextStyle.kNormalTextStyle.copyWith(
                              fontSize: 21,
                              color: AppColors.kWhiteColor,
                            ),
                          ),
                        ),
                        SizedBox(height: AppConstance.kSizedBoxValue),
                        Column(
                          children:
                              courseNotes.map((note) {
                                return Container(
                                  padding: EdgeInsets.all(
                                    AppConstance.kPaddingValue,
                                  ),
                                  margin: EdgeInsets.only(
                                    bottom: AppConstance.kPaddingValue,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      AppConstance.kRoundCornerValue,
                                    ),
                                    gradient: AppColors.kNoteCardColor,
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      GoRouter.of(
                                        context,
                                      ).push("/single-note", extra: note);
                                    },
                                    leading: Icon(
                                      Icons.note_add_sharp,
                                      size: 30,
                                      color: AppColors.kBlueGrey,
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Name: ",
                                          style: AppTextStyle.kBottemLabelStyle
                                              .copyWith(
                                                color: AppColors.kYellowColor,
                                              ),
                                        ),
                                        Text(
                                          note.title,
                                          style: AppTextStyle.kBottemLabelStyle
                                              .copyWith(
                                                color: AppColors.kBlueGrey,
                                              ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Description: ",
                                          style: AppTextStyle.kBottemLabelStyle
                                              .copyWith(
                                                color: AppColors.kYellowColor,
                                              ),
                                        ),
                                        Text(
                                          note.description,
                                          style: AppTextStyle.kBottemLabelStyle
                                              .copyWith(
                                                color: AppColors.kBlueGrey,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ],
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
