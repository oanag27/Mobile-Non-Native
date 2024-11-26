import 'package:flutter_application_1/model/task_model.dart';

class TaskRepository {
  final List<Task> _tasks = [
    Task(
      id: 1,
      title: 'Soup for lunch',
      description: 'Use the vegetables from the fridge for the soup',
      dueDate: DateTime.now().add(Duration(days: 1)),
      priorityLevel: 'High',
      isCompleted: false,
    ),
    Task(
      id: 2,
      title: 'Read a book',
      description: 'Finish the pending book by this weekend',
      dueDate: DateTime.now().add(Duration(days: 3)),
      priorityLevel: 'Medium',
      isCompleted: false,
    ),
  ];

  List<Task> getTasks() => _tasks;

  Task getTaskById(String id) {
    return _tasks.firstWhere((task) => task.id == id);
  }
}
