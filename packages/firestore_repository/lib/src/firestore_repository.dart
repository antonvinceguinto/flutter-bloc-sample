import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/models/signal_model.dart';

class FirestoreRepositoryImpl {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Remove a ride booking from the user's ride bookings.
  Future<void> removeRideBooking(String bookingId) async {
    final rideBookingDoc = _db.collection('rideBookings').doc(bookingId);
    await rideBookingDoc.delete();
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
  }

  /// User CRUD below
  Future<void> saveUserToFirestore(User user) async {
    try {
      final userRef = _db.collection('users').doc(user.id);
      final userSnapshot = await userRef.get();
      if (!userSnapshot.exists) {
        await userRef.set({
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'photo': user.photo,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserDetails(
    String email,
    String name,
    String mobile,
    User currentUser,
  ) async {
    try {
      final userRef = _db.collection('users').doc(currentUser.id);
      final userSnapshot = await userRef.get();
      if (userSnapshot.exists) {
        await userRef.update({
          'name': name,
          'email': email.isEmpty ? currentUser.email : email,
          'photo': currentUser.photo,
          'updatedAt': DateTime.now().millisecondsSinceEpoch.toString(),
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<User> getCurrentUserFromDB(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => User.fromMap(snapshot.data()!));
  }
}
