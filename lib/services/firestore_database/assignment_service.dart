import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_planner/models/assignment_model.dart';

class AssignmentService {
  //Create the Firestore Collection Reference
  final CollectionReference courseCollection = FirebaseFirestore.instance
      .collection("courses");

  //Create a New Assignment into a Course
  Future<void> createAssignment(
    String courseId,
    AssignmentModel assignment,
  ) async {
    try {
      final Map<String, dynamic> data = assignment.toJson();

      //Assignment Collection Reference
      final CollectionReference assignmentCollection = courseCollection
          .doc(courseId)
          .collection("assignments");
      DocumentReference docRef = await assignmentCollection.add(data);

      //Update the Assignment Id with the doc Id
      await docRef.update({"id": docRef.id});
          
    } catch (error) {
      debugPrint("Error: $error");
    }
  }
}
