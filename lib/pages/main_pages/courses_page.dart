import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/helpers/app_helpers.dart';
import 'package:learn_planner/models/assignment_model.dart';
import 'package:learn_planner/models/course_model.dart';
import 'package:learn_planner/models/note_model.dart';
import 'package:learn_planner/pages/add_new_assignment_page.dart';
import 'package:learn_planner/pages/add_new_note_page.dart';
import 'package:learn_planner/services/firestore_database/assignment_service.dart';
import 'package:learn_planner/services/firestore_database/course_service.dart';
import 'package:learn_planner/services/firestore_database/note_service.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_constance.dart';
import 'package:learn_planner/utils/app_text_style.dart';
import 'package:intl/intl.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  // Created a Future variable to store fetched data
  late Future<Map<String, dynamic>> _futureData;

  // Created a local list to store courses and update the UI dynamically
  List<CourseModel> _courses = [];

  @override
  void initState() {
    super.initState();
    _loadData(); // Load data when the widget initializes
  }

  // This method fetches data and updates the `_courses` list
  void _loadData() {
    _futureData = _fetchAllData();
    _futureData.then((data) {
      setState(() {
        _courses = data["courses"] as List<CourseModel>? ?? [];
      });
    });
  }

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

  // Method to delete a course and update the UI immediately
  Future<void> _confirmDeleteCourse(String courseId) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              "Confirm Deletion",
              style: TextStyle(color: AppColors.kWhiteColor),
            ),
            content: Text(
              "Are you sure you want to delete this course?, and you will lose the Course Related Assignment and Notes also.",
              style: AppTextStyle.kBottemLabelStyle.copyWith(
                color: AppColors.kWhiteColor,
                fontSize: 12,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false), // Cancel
                child: Text(
                  "Cancel",
                  style: AppTextStyle.kBottemLabelStyle.copyWith(
                    color: AppColors.kWhiteColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true), // Confirm delete
                child: Text(
                  "Delete",
                  style: AppTextStyle.kBottemLabelStyle.copyWith(
                    color: AppColors.kRedAccentColor,
                  ),
                ),
              ),
            ],
          ),
    );
    if (confirmDelete == true) {
      await CourseService().deleteCourseWithSubcollections(
        courseId,
      ); // Delete course from Firestore
      setState(() {
        _courses.removeWhere(
          (course) => course.id == courseId,
        ); // Remove from local list
      });
      if (mounted) {
        AppHelpers.showSnackBar(context, "Course Deleted Successfully!");
      }
    }
  }

  //Delete a Note
  Future<void> _deleteNote(String courseId, String noteId) async {
    try {
      await NoteService().deleteNote(courseId, noteId);
      setState(() {
        _futureData = _fetchAllData();
      });
      if (mounted) {
        AppHelpers.showSnackBar(context, "Note Deleted Successfully!");
      }
    } catch (error) {
      debugPrint("Error deleting note: $error");
      if (mounted) {
        AppHelpers.showSnackBar(context, "Faild to Delete Note!");
      }
    }
  }

  //Delete a Assignment
  Future<void> _deleteAssignment(String courseId, String assignmnetId) async {
    try {
      await AssignmentService().deleteAssignment(courseId, assignmnetId);
      setState(() {
        _futureData = _fetchAllData();
      });
      if (mounted) {
        AppHelpers.showSnackBar(context, "Assignment Deleted Successfully!");
      }
    } catch (error) {
      debugPrint("Error deleting Assignment: $error");
      if (mounted) {
        AppHelpers.showSnackBar(context, "Faild to Delete Assignment!");
      }
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
          future: _futureData,
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                bool?
                                                isUpdated = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            AddNewAssignmentPage(
                                                              course: course,
                                                              assignmentToEdit:
                                                                  assignment,
                                                            ),
                                                  ),
                                                );
                                                if (isUpdated == true) {
                                                  setState(() {
                                                    _futureData =
                                                        _fetchAllData();
                                                  });
                                                }
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: AppColors.kBlueColor,
                                                size: 32,
                                                shadows: [
                                                  Shadow(
                                                    color: AppColors.kBlackColor
                                                    // ignore: deprecated_member_use
                                                    .withOpacity(0.4),
                                                    blurRadius: 2,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 6),
                                            IconButton(
                                              onPressed: () async {
                                                await _deleteAssignment(
                                                  course.id,
                                                  assignment.id,
                                                );
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color:
                                                    AppColors.kRedAccentColor,
                                                size: 32,
                                                shadows: [
                                                  Shadow(
                                                    color: AppColors.kBlackColor
                                                    // ignore: deprecated_member_use
                                                    .withOpacity(0.4),
                                                    blurRadius: 2,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                                size: 32,
                                                shadows: [
                                                  Shadow(
                                                    color: AppColors.kBlackColor
                                                    // ignore: deprecated_member_use
                                                    .withOpacity(0.4),
                                                    blurRadius: 2,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                              onPressed: () async {
                                                bool? isUpdated =
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (
                                                              context,
                                                            ) => AddNewNotePage(
                                                              course: course,
                                                              noteToEdit: note,
                                                            ),
                                                      ),
                                                    );
                                                if (isUpdated == true) {
                                                  setState(() {
                                                    _futureData =
                                                        _fetchAllData();
                                                  });
                                                }
                                              },
                                            ),
                                            SizedBox(width: 6),
                                            IconButton(
                                              onPressed: () async {
                                                await _deleteNote(
                                                  course.id,
                                                  note.id,
                                                );
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color:
                                                    AppColors.kRedAccentColor,
                                                size: 32,
                                                shadows: [
                                                  Shadow(
                                                    color: AppColors.kBlackColor
                                                    // ignore: deprecated_member_use
                                                    .withOpacity(0.4),
                                                    blurRadius: 2,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ],
                      SizedBox(height: AppConstance.kSizedBoxValue),
                      Center(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              AppColors.kRedAccentColor,
                            ),
                          ),
                          onPressed: () => _confirmDeleteCourse(course.id),
                          label: Text(
                            "Delete Course",
                            style: AppTextStyle.kNormalTextStyle.copyWith(
                              color: AppColors.kWhiteColor,
                              fontSize: 16,
                            ),
                          ),
                          icon: Icon(
                            Icons.delete,
                            size: 24,
                            color: AppColors.kWhiteColor,
                          ),
                        ),
                      ),
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
