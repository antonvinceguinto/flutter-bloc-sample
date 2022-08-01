import 'package:bloc_vgv_todoapp/core/models/signal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addSignalData(Signal signal) async {
    final docRef = _db.collection('signals');
    final user = FirebaseAuth.instance.currentUser;
    final doc = await docRef.get();

    if (doc.docs.isEmpty) {
      await docRef.add({
        'signals': [signal.toMap()],
      });
    } else {
      await docRef.doc().update(
        {
          'signals': FieldValue.arrayUnion([signal.toMap()]),
        },
      );
    }
  }

  Stream<List<Signal>> retrieveSignals() {
    // final docRef = _db.collection('signals');
    // return docRef.snapshots().map((snapshot) {
    //   return snapshot.docs.map((doc) {
    //     return Signal.fromMap(doc.data());
    //   }).toList();
    // });

    // Return list of signals via stream
    return _db.collection('signals').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Signal.fromMap(doc.data());
      }).toList();
    });

    // print('asdasd');

    // final doc = await docRef.get();
    // final signals = <Signal>[];
    // for (final doc in doc.docs) {
    //   final signal = Signal.fromMap(doc.data());
    //   signals.add(signal);
    // }
    // return signals;
  }

  // Future<void> removeSignal(String id) async {
  //   final docTuple = await getDocument();

  //   if (docTuple.item1.exists) {
  //     final todos = (docTuple.item1.data()!['todos'] as List<dynamic>)
  //         .map((e) => Signal.fromMap(e as Map<String, dynamic>))
  //         .toList();

  //     final index = todos.indexWhere((todo) => todo.id == id);

  //     todos.removeAt(index);

  //     await docTuple.item2.update({
  //       'todos': todos.map((todo) => todo.toMap()).toList(),
  //     });
  //   }
  // }
}
