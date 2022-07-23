import 'package:bloc/bloc.dart';
import 'package:bloc_vgv_todoapp/core/models/todo_model.dart';
import 'package:bloc_vgv_todoapp/core/repositories/firestore/firestore_repository.dart';
import 'package:equatable/equatable.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]) {
    _repository.retrieveTodos().then(emit);
  }

  final _repository = FirestoreRepositoryImpl();

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
          Todo(id: id, title: title),
        ),
    );

    // Add to firestore
    _repository.addTodoData(Todo(id: id, title: title));
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

    // Toggle in firestore
    _repository.toggleCompleted(id);
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

    _repository.removeTodo(id);
  }
}
