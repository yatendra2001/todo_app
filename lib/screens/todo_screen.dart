import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/repository/auth/auth_repo.dart';
import 'package:todo_app/repository/task/task_repo.dart';
import 'package:todo_app/screens/login_screen.dart';

enum TaskFilter { all, completed, incomplete }

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _taskController = TextEditingController();
  TaskFilter currentFilter = TaskFilter.all;
  final TaskRepo _taskRepo = TaskRepo();
  final AuthRepo _authRepo = AuthRepo();

  List<Task> tasks = [];
  List<Task> filteredTasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  _fetchTasks() async {
    final response = await _taskRepo.getTasks();
    setState(() {
      tasks = response ?? [];
      filteredTasks = response ?? [];
    });
  }

  Future<List<Task>> _filteredTasks(TaskFilter taskFilter) async {
    setState(() {
      switch (taskFilter) {
        case TaskFilter.completed:
          filteredTasks = tasks.where((task) => task.isCompleted).toList();
          break;
        case TaskFilter.incomplete:
          filteredTasks = tasks.where((task) => !task.isCompleted).toList();
          break;
        case TaskFilter.all:
          filteredTasks = tasks;
          break;
        default:
          _fetchTasks();
      }
    });
    return tasks;
  }

  Future<void> _updateTaskCompletion(Task task, bool newValue) async {
    Task updateTask =
        Task(id: task.id, title: task.title, isCompleted: newValue);
    await _taskRepo.updateTask(task: updateTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('To-Do List'),
        actions: [
          DropdownButton<TaskFilter>(
            value: currentFilter,
            onChanged: (TaskFilter? newValue) {
              setState(() {
                currentFilter = newValue!;
                _filteredTasks(currentFilter);
              });
            },
            items: TaskFilter.values.map((TaskFilter filter) {
              return DropdownMenuItem<TaskFilter>(
                  value: filter,
                  child: Text(
                    filter.toString().split('.').last,
                    style: TextStyle(color: Colors.black),
                  ));
            }).toList(),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authRepo.logout();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          Task task = filteredTasks[index];
          return ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (bool? newValue) {
                _updateTaskCompletion(task, newValue!);
                setState(() {
                  task.isCompleted = newValue;
                });
              },
            ),
            title: Text(task.title),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await _taskRepo.deleteTask(
                    task: Task(
                        id: task.id,
                        title: task.title,
                        isCompleted: task.isCompleted));
                setState(() {
                  tasks.remove(task);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Task'),
              content: TextField(
                controller: _taskController,
                decoration: InputDecoration(hintText: 'Enter task title'),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    log(_taskController.text);
                    if (_taskController.text.isNotEmpty) {
                      final id = ID.unique();
                      await _taskRepo.addTask(
                          task: Task(
                              id: id,
                              title: _taskController.text,
                              isCompleted: false));
                      setState(() {
                        tasks.add(Task(
                            id: id,
                            title: _taskController.text,
                            isCompleted: false));
                      });
                      _taskController.clear();
                      _fetchTasks();

                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Add'),
                ),
                TextButton(
                  onPressed: () {
                    _taskController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
