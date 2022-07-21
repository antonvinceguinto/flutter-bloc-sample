import 'package:bloc_vgv_todoapp/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  AuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  User currentUser = User.empty;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  Future<void> signup({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {}
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {}
  }

  Future<void> loginViaGmail() async {
    try {
      final signIn = await _googleSignIn.signIn();

      final googleAuth = await signIn!.authentication;

      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      debugPrint('Error login via gmail: $e');
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {}
  }
}

extension on firebase_auth.User {
  User get toUser => User(
        id: uid,
        email: email,
        name: displayName,
        avatar: photoURL,
      );
}
