import 'package:flutter/material.dart';

class LearnerProfilePage extends StatefulWidget {
  const LearnerProfilePage({super.key});

  @override
  State<LearnerProfilePage> createState() => _LearnerProfilePageState();
}

class _LearnerProfilePageState extends State<LearnerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("LearnerProfile")));
  }
}
