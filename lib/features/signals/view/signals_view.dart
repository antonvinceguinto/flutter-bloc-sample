import 'package:bloc_vgv_todoapp/core/blocs/app/app_bloc.dart';
import 'package:bloc_vgv_todoapp/core/models/signal_model.dart';
import 'package:bloc_vgv_todoapp/core/repositories/auth_repository.dart';
import 'package:bloc_vgv_todoapp/core/repositories/firestore/firestore_repository.dart';
import 'package:bloc_vgv_todoapp/features/signals/cubit/signals_cubit.dart';
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
      child: BlocProvider<SignalsCubit>(
        create: (_) => SignalsCubit(
          firestoreRepositoryImpl: _firestoreRepository,
        ),
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

    final signals = context.select((SignalsCubit cubit) => cubit.state);

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
      body: RefreshIndicator(
        onRefresh: () {
          return Future.value();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...signals
                  .map(
                    (e) => ListTile(
                      title: Text(e.title),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
