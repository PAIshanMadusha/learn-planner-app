import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_planner/models/notification_model.dart';
import 'package:learn_planner/services/firestore_database/assignment_service.dart';

class NotificationService {
  //create the FireStore Collection Reference
  final CollectionReference notificationCollection = FirebaseFirestore.instance
      .collection("notifications");

  //Store Overdue Assignments as Notifications
  Future<void> storeOverdueAssignments() async {
    try {
      final assignmentsMap =
          await AssignmentService().getAssignmentsByCourseName();

      for (final entry in assignmentsMap.entries) {
        final courseName = entry.key;
        final assignments = entry.value;

        for (final assignment in assignments) {
          //Check weather the Assignment is Already Exsist in the NotificationCollection
          final QuerySnapshot snapshot =
              await notificationCollection
                  .where("assignmentId", isEqualTo: assignment.id)
                  .get();
          if (snapshot.docs.isEmpty) {
            if (DateTime.now().isAfter(assignment.dueDate)) {
              final NotificationModel notificationData = NotificationModel(
                assignmentId: assignment.id,
                assignmentName: assignment.name,
                courseName: courseName,
                description: assignment.description,
                dueDate: assignment.dueDate,
                timePassed: "Overdue",
              );
              await notificationCollection.add(notificationData.toJson());
            }
          }
        }
      }
    } catch (error) {
      debugPrint("Error: $error");
    }
  }

  //Get All Notifications
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final QuerySnapshot snapshot = await notificationCollection.get();

      return snapshot.docs
          .map(
            (doc) =>
                NotificationModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (error) {
      debugPrint("Error: $error");
      return [];
    }
  }
}
