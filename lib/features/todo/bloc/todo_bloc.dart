import 'package:bloc/bloc.dart';
import 'package:bloc_vgv_todoapp/core/models/todo_model.dart';
import 'package:bloc_vgv_todoapp/core/repositories/firestore/firestore_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoading()) {
    on<GetTodoList>((event, emit) {
      final _repository = FirestoreRepositoryImpl();

      print('TodoBloc: GetTodoList');
      emit(TodoLoading());
      _repository.retrieveTodos().then((todos) {
        emit(TodoLoaded(todos));
      });
    });
    on<TodoEvent>((event, emit) {
      print('LOADING TODOS');
    });
  }
}
