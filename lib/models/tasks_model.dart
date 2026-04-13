


class TasksModel {
  final String taskname;
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