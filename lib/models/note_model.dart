import 'dart:io';

class NoteModel {
  final String id;
  final String title;
  final String section;
  final String description;
  final String references;
  final File? imageData;
  final String? imageUrl;

  NoteModel({
    required this.id,
    required this.title,
    required this.section,
    required this.description,
    required this.references,
    this.imageData,
    this.imageUrl,
  });

  //Convert Json Data to Dart Object
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      section: json["section"] ?? "",
      description: json["description"] ?? "",
      references: json["references"] ?? "",
      imageData: json["imageData"],
      imageUrl: json["imageUrl"],
    );
  }

  //Convert Dart Object to Json Data
  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "title": title,
      "section": section,
      "description": description,
      "references": references,
      "imageData": imageData,
      "imageUrl": imageUrl,
    };
  }
}
