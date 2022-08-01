import 'package:bloc_vgv_todoapp/app/app.dart';
import 'package:bloc_vgv_todoapp/bootstrap.dart';
import 'package:bloc_vgv_todoapp/core/repositories/auth_repository.dart';
import 'package:bloc_vgv_todoapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authRepository = AuthRepository();
  await authRepository.user.first;

  await bootstrap(() => App(authRepository: authRepository));
}
