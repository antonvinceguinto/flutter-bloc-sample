import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_vgv_todoapp/core/models/signal_model.dart';
import 'package:bloc_vgv_todoapp/core/repositories/firestore/firestore_repository.dart';
import 'package:equatable/equatable.dart';

part 'signals_state.dart';

class SignalsCubit extends Cubit<List<Signal>> {
  SignalsCubit({required FirestoreRepositoryImpl firestoreRepositoryImpl})
      : super([]) {
    _firestoreRepositoryImpl = firestoreRepositoryImpl;

    Future.delayed(const Duration(milliseconds: 200), () async {
      await retrieveSignals();
    });
  }

  late FirestoreRepositoryImpl _firestoreRepositoryImpl;

  // void add(String title) {
  //   final id = DateTime.now().millisecondsSinceEpoch.toString();
  //   emit(
  //     state
  //         .map(
  //           (signal) => signal.copyWith(
  //             id: signal.id,
  //             title: signal.title,
  //             imageUrl: signal.imageUrl,
  //           ),
  //         )
  //         .toList()
  //       ..add(
  //         Signal(
  //           id: id,
  //           title: title,
  //           imageUrl: '',
  //         ),
  //       ),
  //   );

  //   _repository.addSignalData(
  //     Signal(id: id, title: title, imageUrl: ''),
  //   );
  // }

  Future<void> retrieveSignals() async {
    final res = await _firestoreRepositoryImpl.retrieveSignals();
    emit(res);
  }

  // void updateTodo(String id, String title) {
  //   emit(
  //     state
  //         .map(
  //           (todo) => todo.copyWith(
  //             id: todo.id!,
  //             title: todo.title!,
  //             completed: todo.completed,
  //           ),
  //         )
  //         .toList()
  //       ..removeWhere((todo) => todo.id == id)
  //       ..add(
  //         Signal(id: id, title: title),
  //       ),
  //   );

  //   // Update to firestore
  //   _repository.updateTodoData(Signal(id: id, title: title), title);
  // }

  // void toggle(String id) {
  //   emit(
  //     state
  //         .map(
  //           (todo) => todo.copyWith(
  //             id: todo.id!,
  //             title: todo.title!,
  //             completed: todo.id == id ? !todo.completed : todo.completed,
  //           ),
  //         )
  //         .toList(),
  //   );

  //   // Toggle in firestore
  //   _repository.toggleCompleted(id);
  // }

  // void remove(String id) {
  //   emit(
  //     state
  //         .map(
  //           (todo) => todo.copyWith(
  //             id: todo.id!,
  //             title: todo.title!,
  //             completed: todo.completed,
  //           ),
  //         )
  //         .toList()
  //       ..removeWhere((todo) => todo.id == id),
  //   );

  //   _repository.removeTodo(id);
  // }
}
