import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_vgv_todoapp/app/app.dart';
import 'package:bloc_vgv_todoapp/bootstrap.dart';
import 'package:bloc_vgv_todoapp/firebase_options.dart';
import 'package:coingecko_repository/coingecko_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authRepository = AuthenticationRepository();
  await authRepository.user.first;

  await bootstrap(
    () => App(
      authenticationRepository: authRepository,
      firestoreRepository: FirestoreRepositoryImpl(),
      coingeckoRepository: CoinGeckoRepositoryImpl(),
    ),
  );
}
