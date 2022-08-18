import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_vgv_todoapp/app/app_router.gr.dart';
import 'package:bloc_vgv_todoapp/core/blocs/app/app_bloc.dart';
import 'package:bloc_vgv_todoapp/core/configs/routes.dart';
import 'package:bloc_vgv_todoapp/l10n/l10n.dart';
import 'package:coingecko_repository/coingecko_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AuthenticationRepository authenticationRepository,
    required FirestoreRepositoryImpl firestoreRepository,
    required CoinGeckoRepositoryImpl coingeckoRepository,
  })  : _authenticationRepository = authenticationRepository,
        _firestoreRepository = firestoreRepository,
        _coingeckoRepository = coingeckoRepository;

  final AuthenticationRepository _authenticationRepository;
  final FirestoreRepositoryImpl _firestoreRepository;
  final CoinGeckoRepositoryImpl _coingeckoRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider.value(
          value: _firestoreRepository,
        ),
        RepositoryProvider.value(
          value: _coingeckoRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(authRepository: _authenticationRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late AppRouter router;

  @override
  void initState() {
    router = AppRouter();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          iconColor: Colors.white,
        ),
        textTheme: GoogleFonts.robotoTextTheme().copyWith(
          headline1: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyText2: GoogleFonts.roboto(
            color: Colors.green,
          ),
          subtitle1: GoogleFonts.roboto(
            color: Colors.white,
          ),
          button: GoogleFonts.roboto(
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.black,
          titleTextStyle: GoogleFonts.roboto(
            color: Colors.green,
            fontSize: 18,
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.grey[900],
          titleTextStyle: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF0164FF),
        ),
        dividerTheme: const DividerThemeData(
          color: Colors.green,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.blue,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: Colors.white,
          primaryContrastingColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: const Color(0xFF0164FF),
            padding: const EdgeInsets.all(14),
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationParser: router.defaultRouteParser(),
      routerDelegate: router.delegate(),
    );
  }
}

class AppInitView extends StatelessWidget {
  const AppInitView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder(
      state: context.select((AppBloc bloc) => bloc.state.status),
      onGeneratePages: onGenerateAppViewPages,
    );
  }
}
