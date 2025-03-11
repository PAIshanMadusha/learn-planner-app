import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_planner/pages/main_page.dart';

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
        name: "main",
        builder: (context, state) {
          return MainPage();
        },
      ),
    ],
  );
}
