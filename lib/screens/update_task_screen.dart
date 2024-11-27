import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/task_model.dart';
import 'package:flutter_application_1/provider/task_provider.dart';
import 'package:provider/provider.dart';

class UpdateTaskScreen extends StatefulWidget {
  final Task task;

  const UpdateTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priorityController;
  late DateTime _selectedDate;
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _priorityController =
        TextEditingController(text: widget.task.priorityLevel);
    _selectedDate = widget.task.dueDate;
    _isCompleted = widget.task.isCompleted;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _updateTask() {
    // Create updated task object
    final updatedTask = Task(
      id: widget.task.id,
      title: _titleController.text,
      description: _descriptionController.text,
      priorityLevel: _priorityController.text,
      dueDate: _selectedDate,
      isCompleted: _isCompleted,
    );

    // Update the task in the provider
    context.read<TaskProvider>().updateTask(updatedTask);

    // Navigate back
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Task Description',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priorityController,
              decoration: const InputDecoration(
                labelText: 'Task Priority',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Task Date'),
                const Spacer(),
                TextButton(
                  onPressed: _pickDate,
                  child: Text(
                    _selectedDate.toIso8601String().split('T')[0],
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Completion Status'),
                const Spacer(),
                Switch(
                  value: _isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isCompleted = value;
                    });
                  },
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _updateTask,
                child: const Text('Update Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
