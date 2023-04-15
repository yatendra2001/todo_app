import 'package:todo_app/model/task.dart';

abstract class BaseTaskRepo {
  Future<List<Task>?> getTasks();
  Future<Task?> addTask({required Task task});
  Future<void> deleteTask({required Task task});
  Future<Task?> updateTask({required Task task});
}
