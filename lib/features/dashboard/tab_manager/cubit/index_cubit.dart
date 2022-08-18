import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'index_state.dart';

class IndexCubit extends Cubit<IndexState> {
  IndexCubit() : super(const IndexState(0));

  void updateIndex(int index) => emit(state.copyWith(currentIndex: index));
}
