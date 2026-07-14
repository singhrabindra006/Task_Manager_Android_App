import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/constants/utils.dart';
import 'package:frontend/feature/home/repository/task_remot_repository.dart';
import 'package:frontend/models/task_model.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  final taskRemotRepository = TaskRemotRepository();

  Future<void> createNewTask({
    required String title,
    required String description,
    required Color color,
    required String token,
    required DateTime dueAt,
  }) async {
    try {
      emit(TaskLoading());
      final taskModel = await taskRemotRepository.createTask(
        title: title,
        description: description,
        hexColor: rgbToHex(color),
        token: token,
        dueAt: dueAt,
      );
      emit(AddNewTaskSuccess(taskModel));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> getAllTasks({required String token}) async {
    try {
      emit(TaskLoading());
      final tasks = await taskRemotRepository.getAllTask(token: token);
      emit(GetTaskSuccess(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> deleteTask({
    required String taskId,
    required String token,
  }) async {
    try {
      emit(TaskLoading());
      await taskRemotRepository.deleteTask(taskId: taskId, token: token);
      final tasks = await taskRemotRepository.getAllTask(token: token);
      emit(GetTaskSuccess(tasks, message: 'Task deleted successfully!'));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
