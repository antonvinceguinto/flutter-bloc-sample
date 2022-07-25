import 'package:bloc_vgv_todoapp/app/app.dart';
import 'package:bloc_vgv_todoapp/core/repositories/auth_repository.dart';
import 'package:bloc_vgv_todoapp/features/auth/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/firebase_mock.dart';
import '../../helpers/pump_app.dart';

void main() {
  setupFirebaseAuthMocks();

  group('App', () {
    testWidgets('renders TodoPage', (tester) async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp();

      final auth = AuthRepository();

      await tester.pumpApp(App(authRepository: auth));
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
