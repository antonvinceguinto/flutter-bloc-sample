import 'package:bloc_vgv_todoapp/core/models/signal_model.dart';
import 'package:bloc_vgv_todoapp/core/repositories/firestore/firestore_service.dart';

abstract class DatabaseRepository {
  Future<void> addSignalData(Signal todo);
  // Future<void> setExpired(String id);
  Future<List<Signal>> retrieveSignals();
  // Future<void> removeSignal(String id);
}

class FirestoreRepositoryImpl implements DatabaseRepository {
  FirestoreService service = FirestoreService();

  @override
  Future<void> addSignalData(Signal todo) {
    return service.addSignalData(todo);
  }

  // @override
  // Future<void> setExpired(String id) {
  //   return service.toggleSignal(id);
  // }

  @override
  Future<List<Signal>> retrieveSignals() async {
    return service.retrieveSignals();
  }

  // @override
  // Future<void> removeSignal(String id) {
  //   return service.removeSignal(id);
  // }
}
