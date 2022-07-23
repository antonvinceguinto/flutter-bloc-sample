import 'package:bloc_vgv_todoapp/core/models/todo_model.dart';
import 'package:bloc_vgv_todoapp/core/repositories/firestore/firestore_service.dart';

abstract class DatabaseRepository {
  Future<void> addTodoData(Todo todo);
  Future<void> updateTodoData(Todo todo, String newTitle);
  Future<void> toggleCompleted(String id);
  Future<List<Todo>> retrieveTodos();
  Future<void> removeTodo(String id);
}

class FirestoreRepositoryImpl implements DatabaseRepository {
  FirestoreService service = FirestoreService();

  @override
  Future<void> addTodoData(Todo todo) {
    return service.addTodoData(todo);
  }

  @override
  Future<void> updateTodoData(Todo todo, String newTitle) {
    return service.updateTodoData(todo, newTitle);
  }

  @override
  Future<void> toggleCompleted(String id) {
    return service.toggleTodo(id);
  }

  @override
  Future<List<Todo>> retrieveTodos() {
    return service.retrieveTodos();
  }

  @override
  Future<void> removeTodo(String id) {
    return service.removeTodo(id);
  }
}
