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

  @override
  List<Object> get props => [id!, title!, completed];
}
