import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssignmentModel {
  final String id;
  final String subject;
  final String name;
  final String duration;
  final String description;
  final DateTime startDate;
  final DateTime dueDate;
  final TimeOfDay dueTime;

  AssignmentModel({
    required this.id,
    required this.subject,
    required this.name,
    required this.duration,
    required this.description,
    required this.startDate,
    required this.dueDate,
    required this.dueTime,
  });

  //Convert Json Data to Dart Object
  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json["id"] ?? "",
      subject: json["subject"] ?? "",
      name: json["name"] ?? "",
      duration: json["duration"] ?? "",
      description: json["description"] ?? "",
      startDate: (json["startDate"] as Timestamp).toDate(),
      dueDate: (json["dueDate"] as Timestamp).toDate(),
      dueTime: TimeOfDay.fromDateTime((json["dueTime"] as Timestamp).toDate()),
    );
  }

  //Convert Dart Object to Json Data
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "subject": subject,
      "name": name,
      "duration": duration,
      "description": description,
      "startDate": startDate,
      "dueDate": Timestamp.fromDate(dueDate),
      "dueTime": Timestamp.fromDate(
        DateTime(
          dueDate.year,
          dueDate.month,
          dueDate.day,
          dueDate.hour,
          dueTime.minute,
        ),
      ),
    };
  }
}
