import 'package:hive_flutter/hive_flutter.dart';
import '../models/hive_model.dart'; 

class TaskService {
  static const String boxName = "tasksBox";

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TasksModelAdapter());
  }

  static Future<void> saveTasks(List<TasksModel> tasks) async {
    final box = await Hive.openBox<TasksModel>(boxName);
    await box.clear();
    await box.addAll(tasks);
  }

  static Future<List<TasksModel>> loadTasks() async {
    final box = await Hive.openBox<TasksModel>(boxName);
    return box.values.toList();
  }

  static Future<void> clearAllTasks() async {
    final box = await Hive.openBox<TasksModel>(boxName);
    await box.clear();
  }
}