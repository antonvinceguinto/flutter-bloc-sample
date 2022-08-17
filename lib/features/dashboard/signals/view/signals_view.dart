import 'package:bloc_vgv_todoapp/core/utils/extensions.dart';
import 'package:bloc_vgv_todoapp/features/dashboard/signals/bloc/signals_bloc.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignalsPage extends StatelessWidget {
  const SignalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignalsBloc>(
      create: (_) => SignalsBloc(context.read<FirestoreRepositoryImpl>())
        ..add(const SignalsEvent()),
      child: const SignalsView(),
    );
  }
}

class SignalsView extends StatefulWidget {
  const SignalsView({super.key});

  @override
  State<SignalsView> createState() => _SignalsViewState();
}

class _SignalsViewState extends State<SignalsView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignalsBloc, SignalsState>(
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
    );
  }
}
