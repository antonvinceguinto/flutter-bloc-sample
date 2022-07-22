import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'firestore_event.dart';
part 'firestore_state.dart';

class FirestoreBloc extends Bloc<FirestoreEvent, FirestoreState> {
  FirestoreBloc() : super(FirestoreInitial()) {
    on<FirestoreEvent>((event, emit) {});
  }
}
