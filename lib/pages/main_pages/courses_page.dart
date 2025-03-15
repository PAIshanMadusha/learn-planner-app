import 'package:flutter/material.dart';
import 'package:learn_planner/services/firestore_database/assignment_service.dart';
import 'package:learn_planner/services/firestore_database/course_service.dart';
import 'package:learn_planner/services/firestore_database/note_service.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  Future<Map<String, dynamic>> _fetchAllData() async{
    try{
      final courses = await CourseService().getCourse();
      final assignmentsMap = await AssignmentService().getAssignmentsByCourseName();
      final notesMap = await NoteService().getNotesByCourseName();
       return {
        "courses": courses,
        "assignments": assignmentsMap,
        "notes": notesMap,
       };
    }catch(error){
      debugPrint("Error: $error");
      return {
        "courses": [],
        "assignments": {},
        "notes": {},
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("CoursesPage"),),);
  }
}