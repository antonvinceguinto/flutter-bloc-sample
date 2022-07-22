import 'package:bloc_vgv_todoapp/core/repositories/firestore/firestore_service.dart';
import 'package:bloc_vgv_todoapp/features/todo/cubit/todo_cubit.dart';

abstract class DatabaseRepository {
  Future<void> addTodoData(TodoState todo);
  Future<void> toggleCompleted(String id);
  Future<List<TodoState>> retrieveTodos();
  Future<void> removeTodo(String id);
}

class FirestoreRepositoryImpl implements DatabaseRepository {
  FirestoreService service = FirestoreService();

  @override
  Future<void> addTodoData(TodoState todo) {
    return service.addTodoData(todo);
  }

  @override
  Future<void> toggleCompleted(String id) {
    return service.toggleTodo(id);
  }

  @override
  Future<List<TodoState>> retrieveTodos() {
    return service.retrieveTodos();
  }

  @override
  Future<void> removeTodo(String id) {
    return service.removeTodo(id);
  }
}
