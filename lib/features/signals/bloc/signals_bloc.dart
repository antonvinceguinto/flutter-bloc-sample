import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/models/signal_model.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'signals_event.dart';
part 'signals_state.dart';

class SignalsBloc extends Bloc<SignalsEvent, SignalsState> {
  SignalsBloc(this.firestoreRepositoryImpl) : super(SignalsLoading()) {
    on<SignalsEvent>((event, emit) async {
      emit(SignalsLoading());
      await emit.onEach<List<Signal>>(
        firestoreRepositoryImpl.retrieveSignals(),
        onData: (data) {
          emit(SignalsLoaded(signals: data));
        },
      );
    });
  }
  final FirestoreRepositoryImpl firestoreRepositoryImpl;
}
