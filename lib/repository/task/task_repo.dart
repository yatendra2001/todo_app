import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/repository/task/base_task_repo.dart';

class TaskRepo extends BaseTaskRepo {
  late Client client;
  late Account account;
  late Databases database;
  final String databaseId = "643aafac8acd9981cb15";
  final String collectionId = "643aafb36e1f89c08eb2";

  TaskRepo() {
    client = Client()
        .setEndpoint('http://localhost/v1')
        .setProject('643a8920d822f0edb885')
        .setSelfSigned(status: true);
    account = Account(client);
    database = Databases(client);
  }

  @override
  Future<List<Task>?> getTasks() async {
    try {
      final response = await database.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
      );
      final data = response.documents;
      final tasks = data.map((e) => Task.fromMap(e)).toList();
      return tasks;
    } catch (error) {
      log("get tasks error: ${error.toString()}");
    }
  }

  @override
  Future<Task?> addTask({required Task task}) async {
    try {
      final response = await database.createDocument(
        documentId: task.id,
        databaseId: databaseId,
        collectionId: collectionId,
        data: task.toMap(),
      );
      log(response.data.toString());
      return Task.fromMap(response);
    } catch (error) {
      log("add task error: ${error.toString()}");
    }
    return null;
  }

  @override
  Future<Task?> updateTask({required Task task}) async {
    try {
      final response = await database.updateDocument(
        documentId: task.id,
        databaseId: databaseId,
        collectionId: collectionId,
        data: task.toMap(),
      );
      return Task.fromMap(response);
    } catch (error) {
      log("update task error: ${error.toString()}");
    }
    return null;
  }

  @override
  Future<void> deleteTask({required Task task}) async {
    try {
      final response = await database.deleteDocument(
        documentId: task.id,
        databaseId: databaseId,
        collectionId: collectionId,
      );
    } catch (error) {
      log("delete task error: ${error.toString()}");
    }
  }
}
