import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_planner/models/note_model.dart';
import 'package:learn_planner/services/cloud_storage/store_images_service.dart';

class NoteService {
  //Create the Firestore Collection Reference
  final CollectionReference courseCollection = FirebaseFirestore.instance
      .collection("courses");

  //Create a New Note into a Course
  Future<void> createNote(String courseId, NoteModel note) async {
    try {
      //Store the Image in Firebase Storage
      String? imageUrl;
      if (note.imageData != null) {
        imageUrl = await StoreImagesService().uploadImage(
          noteImage: note.imageData!,
          courseId: courseId,
        );
      }

      //Create a New Note Object
      final NoteModel newNote = NoteModel(
        id: "",
        title: note.title,
        section: note.section,
        description: note.description,
        references: note.references,
        imageUrl: imageUrl,
      );

      //Add note to the Collection
      final DocumentReference docRef = await courseCollection
          .doc(courseId)
          .collection("notes")
          .add(newNote.toJson());

      await docRef.update({"id": docRef.id});
          
    } catch (error) {
      debugPrint("Error: $error");
    }
  }
}
