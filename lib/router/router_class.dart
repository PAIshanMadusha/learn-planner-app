import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/models/course_model.dart';
import 'package:learn_planner/pages/add_new_assignment_page.dart';
import 'package:learn_planner/pages/add_new_course_page.dart';
import 'package:learn_planner/pages/add_new_note_page.dart';
import 'package:learn_planner/pages/main_page.dart';
import 'package:learn_planner/pages/single_course_page.dart';

class RouterClass {
  final router = GoRouter(
    initialLocation: "/",
    errorPageBuilder: (context, state) {
      return const MaterialPage(
        child: Scaffold(
          body: Center(child: Text("this Page is not Available!")),
        ),
      );
    },
    routes: [
      //HomePage
      GoRoute(
        path: "/",
        name: "Main",
        builder: (context, state) {
          return MainPage();
        },
      ),
      //Add new Course
      GoRoute(
        path: "/add-new-course",
        name: "Add New Course",
        builder: (context, state) {
          return AddNewCoursePage();
        },
      ),
      //Single Course
      GoRoute(
        path: "/single-course",
        name: "Single Course",
        builder: (context, state) {
          final CourseModel course = state.extra as CourseModel;
          return SingleCoursePage(course: course);
        },
      ),
      //Add a New Assignment Page
      GoRoute(
        path: "/add-new-assignment",
        name: "Add New Assignment",
        builder: (context, state) {
          final CourseModel course = state.extra as CourseModel;
          return AddNewAssignmentPage(course: course);
        },
      ),
      //Add a New Note Page
      GoRoute(
        path: "/add-new-note",
        name: "Add New Note",
        builder: (context, state) {
          final CourseModel course = state.extra as CourseModel;
          return AddNewNotePage(course: course);
        },
      ),
    ],
  );
}
