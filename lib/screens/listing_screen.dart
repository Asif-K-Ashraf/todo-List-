import 'package:flutter/material.dart';
import 'package:todo_list/services/hive_services.dart';
import '../models/hive_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController controller = TextEditingController();

  List<TasksModel> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    tasks = await TaskService.loadTasks();
    setState(() {});
  }

  void saveTasks() {
    TaskService.saveTasks(tasks);
  }

  void addTask() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      tasks.add(TasksModel(taskname: controller.text.trim(), taskdone: false));
      controller.clear();
    });

    saveTasks();
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index] = TasksModel(
        taskname: tasks[index].taskname,
        taskdone: !tasks[index].taskdone,
      );
    });

    saveTasks();
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });

    saveTasks();
  }

  void editTask(int index) {
    TextEditingController editController = TextEditingController(
      text: tasks[index].taskname,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Task"),
        content: TextField(controller: editController),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                tasks[index] = TasksModel(
                  taskname: editController.text,
                  taskdone: tasks[index].taskdone,
                );
              });
              saveTasks();
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void clearCompleted() {
    setState(() {
      tasks.removeWhere((task) => task.taskdone);
    });

    saveTasks();
  }

  void deleteAll() {
    setState(() {
      tasks.clear();
    });

    saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    final pending = tasks.where((t) => !t.taskdone).toList();
    final completed = tasks.where((t) => t.taskdone).toList();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            "To-Do List",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Enter new task",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    onPressed: addTask,
                    icon: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                      child: Text(
                        "Add New Tasks",
                        style: TextStyle(fontSize: 25),
                      ),
                    )
                  : ListView(
                      children: [
                        const Text(
                          "Pending Tasks",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        ...pending.map((task) {
                          int index = tasks.indexOf(task);
                          return buildTile(task, index);
                        }),

                        pending.isEmpty
                            ? const Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                      "Add New Tasks",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              )
                            : const SizedBox(height: 20),

                        const Text(
                          "Completed",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        ...completed.map((task) {
                          int index = tasks.indexOf(task);
                          return buildTile(task, index);
                        }),
                        completed.isEmpty
                            ? const Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                      "No Completed Tasks",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              )
                            : const SizedBox(height: 20),
                      ],
                    ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: clearCompleted,
                      child: const Text(
                        "Clear Completed",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: deleteAll,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        "Delete All",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTile(TasksModel task, int index) {
    return ListTile(
      leading: Checkbox(
        value: task.taskdone,
        onChanged: (_) => toggleTask(index),
      ),
      title: Text(
        task.taskname,
        style: TextStyle(
          decoration: task.taskdone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => editTask(index),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => deleteTask(index),
          ),
        ],
      ),
    );
  }
}
