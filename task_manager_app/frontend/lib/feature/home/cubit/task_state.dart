part of 'task_cubit.dart';

sealed class TaskState {
  const TaskState();
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskError extends TaskState {
  final String error;
  TaskError(this.error);
}

final class AddNewTaskSuccess extends TaskState {
  final TaskModel taskModel;
  const AddNewTaskSuccess(this.taskModel);
}

final class GetTaskSuccess extends TaskState {
  final List<TaskModel> tasks;
  final String? message; // optional success message

  const GetTaskSuccess(this.tasks, {this.message});

  @override
  bool operator ==(Object other) =>
      other is GetTaskSuccess &&
      other.tasks == tasks &&
      other.message == message;

  @override
  int get hashCode => tasks.hashCode ^ message.hashCode;
}
