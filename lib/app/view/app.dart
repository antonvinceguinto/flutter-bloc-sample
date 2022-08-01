import 'package:bloc_vgv_todoapp/app/app_router.gr.dart';
import 'package:bloc_vgv_todoapp/core/blocs/app/app_bloc.dart';
import 'package:bloc_vgv_todoapp/core/configs/routes.dart';
import 'package:bloc_vgv_todoapp/core/repositories/auth_repository.dart';
import 'package:bloc_vgv_todoapp/l10n/l10n.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(authRepository: _authRepository),
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
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme().copyWith(
          headline1: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF0164FF),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF0164FF),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: const Color(0xFF0164FF),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: const Color(0xFF0164FF),
            padding: const EdgeInsets.all(18),
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
