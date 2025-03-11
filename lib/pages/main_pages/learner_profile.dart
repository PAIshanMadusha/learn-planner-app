import 'package:flutter/material.dart';

class LearnerProfile extends StatefulWidget {
  const LearnerProfile({super.key});

  @override
  State<LearnerProfile> createState() => _LearnerProfileState();
}

class _LearnerProfileState extends State<LearnerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("LearnerProfile")));
  }
}
