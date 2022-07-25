part of 'todo_bloc.dart';

@immutable
class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {
  TodoLoading();

  @override
  List<Object> get props => [];
}

class TodoLoaded extends TodoState {
  TodoLoaded(this.todos);

  final List<Todo>? todos;

  @override
  List<Object> get props => [todos!];
}
