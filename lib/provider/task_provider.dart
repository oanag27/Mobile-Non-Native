import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/model/task_model.dart';
import '../repository/task_repository.dart';

class TaskProvider with ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  late List<Task> _tasks;

  TaskProvider() {
    _tasks = _repository.getTasks();
  }

  List<Task> get tasks => _tasks;

  void toggleTaskCompletion(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners(); // Notify the UI to update the specific item
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  Task getTaskById(String id) {
    return _repository.getTaskById(id);
  }
}
