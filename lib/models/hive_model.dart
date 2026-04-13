import 'package:hive/hive.dart';

part 'hive_model.g.dart';  // ← CHANGE THIS LINE

@HiveType(typeId: 0)
class TasksModel {
  @HiveField(0)
  final String taskname;
  
  @HiveField(1)
  final bool taskdone;

  TasksModel({
    required this.taskname,
    required this.taskdone,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskname': taskname,
      'taskdone': taskdone,
    };
  }

  factory TasksModel.fromMap(Map<String, dynamic> map) {
    return TasksModel(
      taskname: map['taskname'] ?? '',
      taskdone: map['taskdone'] ?? false,
    );
  }
}