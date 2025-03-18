import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_planner/models/course_model.dart';

class CourseService {
  //create the FireStore Collection Reference
  final CollectionReference courseCollection = FirebaseFirestore.instance
      .collection("courses");

  //Add a New Course
  Future<void> createNewCourse(CourseModel course) async {
    try {
      //Convert the Course Object to a Map
      final Map<String, dynamic> data = course.toJson();

      //Add the Course to the Collection
      final DocumentReference docRef = await courseCollection.add(data);

      //Update the Document with Generated Id
      await docRef.update({"id": docRef.id});
    } catch (error) {
      debugPrint("Error Creating a Course: $error");
    }
  }

  //Get All Courses as a Stream
  Stream<List<CourseModel>> get courses {
    try {
      return courseCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map(
              (doc) => CourseModel.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList();
      });
    } catch (error) {
      debugPrint("Error: $error");
      return Stream.empty();
    }
  }

  //Get Courses as a List
  Future<List<CourseModel>> getCourse() async {
    try {
      final QuerySnapshot snapshot = await courseCollection.get();
      return snapshot.docs.map((doc) {
        return CourseModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (error) {
      debugPrint("Error: $error");
      return [];
    }
  }

  //Delete a Course
  Future<void> deleteCourse(String id) async {
    try {
      await courseCollection.doc(id).delete();
      debugPrint("Course Deleted!");
    } catch (error) {
      debugPrint("Error Deleting a Course: $error");
    }
  }
}
