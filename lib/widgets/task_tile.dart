import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final int index;
  final VoidCallback onToggle;

  const TaskTile({
    super.key,
    required this.task,
    required this.index,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration:
              task.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
        ),
      ),
      subtitle: Text(
        'Created: ${DateFormat.yMMMd().format(task.createdDate)}',
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          onToggle();
        },
      ),
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            final TextEditingController titleController = TextEditingController(
              text: task.title,
            );
            return AlertDialog(
              title: Text('Edit Task'),
              content: TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Enter new task title'),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      Provider.of<TaskProvider>(
                        context,
                        listen: false,
                      ).updateTask(index, titleController.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Update'),
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<TaskProvider>(
                      context,
                      listen: false,
                    ).deleteTask(index);
                    Navigator.of(context).pop();
                  },
                  child: Text('Delete'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
