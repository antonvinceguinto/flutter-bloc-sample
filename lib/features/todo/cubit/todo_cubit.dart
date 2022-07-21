import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<List<TodoState>> {
  TodoCubit() : super([]);

  void add(String title) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    emit(
      state
          .map(
            (todo) => todo.copyWith(
              id: todo.id!,
              title: todo.title!,
              completed: todo.completed,
            ),
          )
          .toList()
        ..add(
          TodoState(id: id, title: title),
        ),
    );
  }

  void toggle(String id) {
    emit(
      state
          .map(
            (todo) => todo.copyWith(
              id: todo.id!,
              title: todo.title!,
              completed: todo.id == id ? !todo.completed : todo.completed,
            ),
          )
          .toList(),
    );
  }

  void remove(String id) {
    emit(
      state
          .map(
            (todo) => todo.copyWith(
              id: todo.id!,
              title: todo.title!,
              completed: todo.completed,
            ),
          )
          .toList()
        ..removeWhere((todo) => todo.id == id),
    );
  }
}
