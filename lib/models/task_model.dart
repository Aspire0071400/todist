import 'dart:convert';

class TaskModel {
  String title;
  bool isCompleted;
  final DateTime createdDate;

  TaskModel({
    required this.title,
    this.isCompleted = false,
    required this.createdDate,
  });

  // Convert a TaskModel instance to a JSON string
  String toJson() => json.encode({
    'title': title,
    'isCompleted': isCompleted,
    'createdDate': createdDate.toIso8601String(),
  });

  // Create a TaskModel instance from a JSON string
  factory TaskModel.fromJson(String source) => TaskModel(
    title: json.decode(source)['title'],
    isCompleted: json.decode(source)['isCompleted'],
    createdDate: DateTime.parse(json.decode(source)['createdDate']),
  );
}
