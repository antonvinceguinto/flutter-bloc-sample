import 'package:bloc_vgv_todoapp/features/todo/cubit/todo_cubit.dart';

class Todo extends TodoState {
  const Todo({
    required String super.id,
    required String super.title,
    super.completed,
  });

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      completed: map['completed'] as bool,
    );
  }

  Todo copyWith({
    required String id,
    required String title,
    required bool completed,
  }) {
    return Todo(
      id: id,
      title: title,
      completed: completed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
