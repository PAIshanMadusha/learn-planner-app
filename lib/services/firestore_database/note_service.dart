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

  //Get All the Notes Inside the Course
  Stream<List<NoteModel>> getNotes(String courseId) {
    try {
      final CollectionReference notesCollection = courseCollection
          .doc(courseId)
          .collection("notes");
      return notesCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map(
              (doc) => NoteModel.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList();
      });
    } catch (error) {
      debugPrint("Error: $error");
      return Stream.empty();
    }
  }

  //Get All Note with Course Name
  Future<Map<String, List<NoteModel>>> getNotesByCourseName() async {
    try {
      final QuerySnapshot snapshot = await courseCollection.get();
      Map<String, List<NoteModel>> notesMap = {};

      for (final doc in snapshot.docs) {
        //Course Id
        final String courseId = doc.id;

        //All the Notes Inside the Course
        final List<NoteModel> notes = await getNotes(courseId).first;

        //Create a New Key Value Pairs with the Course Name and the List of Notes
        notesMap[doc["name"]] = notes;
      }
      return notesMap;
      
    } catch (error) {
      debugPrint("Error: $error");
      return {};
    }
  }
}
