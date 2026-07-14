import 'dart:convert';

import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/models/task_model.dart';
import 'package:http/http.dart' as http;

class TaskRemotRepository {
  Future<TaskModel> createTask({
    required String title,
    required String description,
    required String hexColor,
    required String token,
    required DateTime dueAt,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("${Constants.backendUri}/task/addTask"),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        body: jsonEncode({
          'title': title,
          'description': description,
          'hexColor': hexColor,
          'dueAt': dueAt.toIso8601String(),
        }),
      );
      if (res.statusCode != 201) {
        throw jsonDecode(res.body)['message'];
      }
      return TaskModel.fromJson(res.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TaskModel>> getAllTask({required String token}) async {
    try {
      final res = await http.get(
        Uri.parse("${Constants.backendUri}/task/getAllTask"),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
      final listOfTask = jsonDecode(res.body);
      final List<TaskModel> tasksList = [];
      for (var element in listOfTask) {
        tasksList.add(TaskModel.fromMap(element));
      }
      return tasksList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask({
    required String taskId,
    required String token,
  }) async {
    try {
      final uri = Uri.parse("${Constants.backendUri}/task/deleteTask");
      final request = http.Request('DELETE', uri);
      request.headers.addAll({
        'Content-Type': 'application/json',
        'x-auth-token': token,
      });
      request.body = jsonEncode({'taskId': taskId});

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
