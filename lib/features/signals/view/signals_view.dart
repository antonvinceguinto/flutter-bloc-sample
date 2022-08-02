import 'package:bloc_vgv_todoapp/core/blocs/app/app_bloc.dart';
import 'package:bloc_vgv_todoapp/core/models/signal_model.dart';
import 'package:bloc_vgv_todoapp/core/repositories/auth_repository.dart';
import 'package:bloc_vgv_todoapp/core/repositories/firestore/firestore_repository.dart';
import 'package:bloc_vgv_todoapp/core/utils/extensions.dart';
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
          style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
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
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.signals.length + 5,
                itemBuilder: (context, index) {
                  final signal = state.signals[0];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '🚨 ${signal.title}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            if (signal.isExpired)
                              Text(
                                'Expired!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      letterSpacing: 1,
                                    ),
                              )
                            else
                              Text(
                                'NEW!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      letterSpacing: 1,
                                    ),
                              ),
                          ],
                        ),
                        // Parse timestamp
                        Text(
                          signal.timestamp.toDate().readableDate,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.grey[200],
                              ),
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Instructions:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: Colors.grey.shade500,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(signal.details),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Image.network(
                          signal.imageUrl,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
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
