import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];

  TaskProvider() {
    _loadTasks();
  }

  List<TaskModel> get tasks => _tasks;

  void _loadTasks() {
    var box = Hive.box('tasks');
    _tasks =
        box.values.map((taskJson) => TaskModel.fromJson(taskJson)).toList();
    notifyListeners();
  }

  void addTask(String title) {
    var box = Hive.box('tasks');
    var task = TaskModel(title: title, createdDate: DateTime.now());
    box.add(task.toJson());
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTaskCompletion(int index) {
    var box = Hive.box('tasks');
    var task = _tasks[index];
    task.isCompleted = !task.isCompleted;
    box.putAt(index, task.toJson());
    notifyListeners();
  }

  void deleteTask(int index) {
    var box = Hive.box('tasks');
    box.deleteAt(index);
    _tasks.removeAt(index);
    notifyListeners();
  }

  void updateTask(int index, String newTitle) {
    var box = Hive.box('tasks');
    var task = _tasks[index];
    task.title = newTitle;
    box.putAt(index, task.toJson());
    notifyListeners();
  }
}
