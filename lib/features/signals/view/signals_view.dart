import 'package:bloc_vgv_todoapp/core/blocs/app/app_bloc.dart';
import 'package:bloc_vgv_todoapp/core/models/signal_model.dart';
import 'package:bloc_vgv_todoapp/core/repositories/auth_repository.dart';
import 'package:bloc_vgv_todoapp/core/repositories/firestore/firestore_repository.dart';
import 'package:bloc_vgv_todoapp/features/signals/bloc/signals_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignalsPage extends StatelessWidget {
  SignalsPage({super.key});

  static Page<dynamic> page() => MaterialPage(child: SignalsPage());

  final _firestoreRepository = FirestoreRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _firestoreRepository,
      child: BlocProvider<SignalsBloc>(
        create: (_) =>
            SignalsBloc(_firestoreRepository)..add(const SignalsEvent()),
        child: const SignalsView(),
      ),
    );
  }
}

class SignalsView extends StatefulWidget {
  const SignalsView({super.key});

  @override
  State<SignalsView> createState() => _SignalsViewState();
}

class _SignalsViewState extends State<SignalsView> {
  static const verificationStatusHeight = 38.0;

  @override
  Widget build(BuildContext context) {
    final _isEmailVerified =
        context.read<AuthRepository>().currentUser.emailVerified ?? false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(
            double.infinity,
            _isEmailVerified ? 0 : verificationStatusHeight,
          ),
          child: _isEmailVerified
              ? const SizedBox()
              : Container(
                  height: verificationStatusHeight,
                  color: Colors.amber,
                  child: Center(
                    child: Text(
                      'Please verify your email address',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                ),
        ),
        title: Text(
          'SW8 Signals',
          style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                color: Colors.black,
              ),
        ),
        leading: IconButton(
          onPressed: () => context.read<AppBloc>().add(
                AppLogoutRequested(),
              ),
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: BlocBuilder<SignalsBloc, SignalsState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, SignalsState state) {
          if (state is SignalsLoaded) {
            return RefreshIndicator(
              onRefresh: () {
                BlocProvider.of<SignalsBloc>(context).add(const SignalsEvent());
                return Future.value();
              },
              child: ListView.builder(
                itemCount: state.signals.length,
                itemBuilder: (context, index) {
                  final signal = state.signals[index];
                  return ListTile(
                    title: Text(signal.title),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
