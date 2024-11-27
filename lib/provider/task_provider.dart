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

  void toggleTaskCompletion(int id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners(); // Notify the UI to update the specific item
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(int id) {
    _repository.deleteTask(id); // Update the repository
    _tasks.removeWhere((task) => task.id == id); // Update the provider's list
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  Task getTaskById(int id) {
    return _repository.getTaskById(id);
  }
}
