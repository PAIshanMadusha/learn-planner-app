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

  //Get All the Assignment Inside the Course
  Stream<List<AssignmentModel>> getAssignments(String courseId) {
    try {
      //Assignment Collection Reference
      final CollectionReference assignmentCollection = courseCollection
          .doc(courseId)
          .collection("assignments");

      return assignmentCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map(
              (doc) =>
                  AssignmentModel.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList();
      });
    } catch (error) {
      debugPrint("Error: $error");
      return Stream.empty();
    }
  }

  //Get all the Assignment with Course Name
  Future<Map<String, List<AssignmentModel>>> getAssignmentsByCourseName() async {
    try {
      final QuerySnapshot snapshot = await courseCollection.get();

      final Map<String, List<AssignmentModel>> assignmentsMap = {};

      for (final doc in snapshot.docs) {
        //Course Id
        final String courseId = doc.id;

        //All the Assignment Inside the Course
        final List<AssignmentModel> assignments =
            await getAssignments(courseId).first;

        //Create a New Key Value Pair with the Course Name and the List of Assignment
        assignmentsMap[doc["name"]] = assignments;
      }
      return assignmentsMap;
    } catch (error) {
      debugPrint("Error: $error");
      return {};
    }
  }
}
