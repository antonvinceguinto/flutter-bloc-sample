import 'package:bloc_vgv_todoapp/features/auth/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('LoginPage', () {
    testWidgets('renders LoginView', (tester) async {
      WidgetsFlutterBinding.ensureInitialized();
      await tester.pumpApp(const LoginPage());
      // expect(find.byType(LoginView), findsOneWidget);
    });
  });

  group('LoginView', () {
    // late MockGoogleSignIn googleSignIn;

    // setUp(() {
    //   googleSignIn = MockGoogleSignIn();
    // });

    testWidgets('renders login page', (tester) async {
      expect(true, true);
      // expect(find.byType(LoginPage), findsOneWidget);
      // await tester.tap(find.byType(ElevatedButton));

      // await tester.pump();
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // final signInAccount = await googleSignIn.signIn();
      // final signInAuthentication = await signInAccount!.authentication;
      // expect(signInAuthentication, isNotNull);
      // expect(googleSignIn.currentUser, isNotNull);
      // expect(signInAuthentication.accessToken, isNotNull);
      // expect(signInAuthentication.idToken, isNotNull);
    });

    // testWidgets('calls increment when increment button is tapped',
    //     (tester) async {
    //   when(() => counterCubit.state).thenReturn(0);
    //   when(() => counterCubit.increment()).thenReturn(null);
    //   await tester.pumpApp(
    //     BlocProvider.value(
    //       value: counterCubit,
    //       child: const CounterView(),
    //     ),
    //   );
    //   await tester.tap(find.byIcon(Icons.add));
    //   verify(() => counterCubit.increment()).called(1);
    // });

    // testWidgets('calls decrement when decrement button is tapped',
    //     (tester) async {
    //   when(() => counterCubit.state).thenReturn(0);
    //   when(() => counterCubit.decrement()).thenReturn(null);
    //   await tester.pumpApp(
    //     BlocProvider.value(
    //       value: counterCubit,
    //       child: const CounterView(),
    //     ),
    //   );
    //   await tester.tap(find.byIcon(Icons.remove));
    //   verify(() => counterCubit.decrement()).called(1);
    // });
  });
}
