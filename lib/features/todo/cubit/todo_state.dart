part of 'todo_cubit.dart';

class TodoState extends Equatable {
  const TodoState({
    required this.id,
    required this.title,
    this.completed = false,
  });

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

  @override
  List<Object> get props => [id!, title!, completed];
}
