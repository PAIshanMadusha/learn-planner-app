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
  Future<void> deleteCourseWithSubcollections(String courseId) async {
    try {
      // Reference to the course document
      DocumentReference courseRef = courseCollection.doc(courseId);

      // Delete all assignments subcollection documents
      QuerySnapshot assignmentsSnapshot =
          await courseRef.collection('assignments').get();
      for (DocumentSnapshot doc in assignmentsSnapshot.docs) {
        await doc.reference.delete();
      }

      // Delete all notes subcollection documents
      QuerySnapshot notesSnapshot = await courseRef.collection('notes').get();
      for (DocumentSnapshot doc in notesSnapshot.docs) {
        await doc.reference.delete();
      }

      // Finally, delete the course document
      await courseRef.delete();

      debugPrint("Course and its subcollections deleted successfully!");
    } catch (error) {
      debugPrint("Error deleting course and its subcollections: $error");
    }
  }

  //Update a Course Method
  Future<void> updateCourse(CourseModel course) async {
    try {
      await courseCollection.doc(course.id).update(course.toJson());
    } catch (error) {
      debugPrint("Error Updating Course: $error");
    }
  }
}
