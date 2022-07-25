import 'package:bloc_vgv_todoapp/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  AuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
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
      final _user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _user.user?.sendEmailVerification();
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

  Future<void> loginViaGmail() async {
    try {
      final signIn = await _googleSignIn.signIn();

      final googleAuth = await signIn!.authentication;

      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (err) {
      if (err is firebase_auth.FirebaseAuthException) {
        throw Exception(err.message);
      }
      throw Exception('Something went wrong');
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

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (err) {
      if (err is firebase_auth.FirebaseAuthException) {
        throw Exception(err.message);
      }
      throw Exception(err.toString());
    }
  }
}

extension on firebase_auth.User {
  User get toUser => User(
        id: uid,
        email: email,
        name: displayName,
        avatar: photoURL,
        emailVerified: emailVerified,
      );
}
