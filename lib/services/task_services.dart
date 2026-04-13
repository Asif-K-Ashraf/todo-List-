import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/tasks_model.dart';

class TaskService {
  static const String key = "tasks";

  static Future<void> saveTasks(List<TasksModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> data = tasks.map((task) => jsonEncode(task.toMap())).toList();

    await prefs.setStringList(key, data);
  }

  static Future<List<TasksModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? data = prefs.getStringList(key);

    if (data == null) return [];

    return data
        .map((taskString) => TasksModel.fromMap(jsonDecode(taskString)))
        .toList();
  }

  static Future<void> clearAllTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
