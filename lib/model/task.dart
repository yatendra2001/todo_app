// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:appwrite/models.dart';

class Task {
  final String id;
  final String title;
  bool isCompleted;
  Task({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Document doc) {
    final id = doc.$id;
    final map = doc.data;
    return Task(
      id: id,
      title: map['title'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }
}
