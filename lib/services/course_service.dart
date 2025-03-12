import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_planner/models/course_model.dart';

class CourseService {
  //create the FireStore Collection Reference
  final CollectionReference courseCollection = FirebaseFirestore.instance
      .collection("courses");

  //Add a New Course
  Future<void> createNewCourse(CourseModel course) async{
    try{
      //Convert the Course Object to a Map
      final Map<String, dynamic> data = course.toJson();

      //Add the Course to the Collection
      final DocumentReference docRef = await courseCollection.add(data);

      //Update the Document with Generated Id
      await docRef.update({"id": docRef.id});

    }catch(error){
      debugPrint("Error Creating a Course: $error");
    }
  }    
}
