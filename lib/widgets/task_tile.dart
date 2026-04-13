// import 'package:flutter/material.dart';
// import '../models/tasks_model.dart';

// class TaskTile extends StatelessWidget {
//   final TasksModel task;
//   final VoidCallback onToggle;
//   final VoidCallback onDelete;
//   final VoidCallback onEdit;

//   const TaskTile({
//     super.key,
//     required this.task,
//     required this.onToggle,
//     required this.onDelete,
//     required this.onEdit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Checkbox(
//         value: task.taskdone,
//         onChanged: (_) => onToggle(),
//       ),

//       title: Text(
//         task.taskname,
//         style: TextStyle(
//           decoration:
//               task.taskdone ? TextDecoration.lineThrough : null,
//         ),
//       ),

//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: onEdit,
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: onDelete,
//           ),
//         ],
//       ),
//     );
//   }
// }
