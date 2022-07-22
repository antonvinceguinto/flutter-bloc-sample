part of 'todo_cubit.dart';

class TodoState extends Equatable {
  const TodoState({
    required this.id,
    required this.title,
    this.completed = false,
  });

  factory TodoState.fromMap(Map<String, dynamic> map) {
    return TodoState(
      id: map['id'] as String,
      title: map['title'] as String,
      completed: map['completed'] as bool,
    );
  }

  final String? id;
  final String? title;
  final bool completed;

  TodoState copyWith({
    required String id,
    required String title,
    required bool completed,
  }) {
    return TodoState(
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

  @override
  List<Object> get props => [id!, title!, completed];
}
