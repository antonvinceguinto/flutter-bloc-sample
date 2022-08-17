import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/src/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final _firestore = FirestoreRepositoryImpl();

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  User currentUser = User.empty;

  bool get isEmailVerified => currentUser.emailVerified ?? false;

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      late final AuthCredential credential;

      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);

      _firestore.saveUserToFirestore(currentUser);
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (err) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<void> signup({required String email, required String password}) async {
    try {
      final _user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _user.user?.sendEmailVerification();
      await _firestore.saveUserToFirestore(_user.user?.toUser ?? currentUser);
    } catch (err) {
      if (err is firebase_auth.FirebaseAuthException) {
        throw Exception(err.message);
      }
      throw Exception('Something went wrong');
    }
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
    } catch (err) {
      if (err is firebase_auth.FirebaseAuthException) {
        throw Exception(err.message);
      }
      throw Exception(err.toString());
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (err) {
      if (err is firebase_auth.FirebaseAuthException) {
        throw Exception(err.message);
      }
      throw Exception('Something went wrong');
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
      emailVerified: emailVerified,
    );
  }
}
