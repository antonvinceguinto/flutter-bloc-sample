import 'dart:ui';
import 'package:bloc_vgv_todoapp/features/dashboard/signals/bloc/signals_bloc.dart';
import 'package:bloc_vgv_todoapp/features/dashboard/signals/widgets/crypto_ticker.dart';
import 'package:bloc_vgv_todoapp/features/dashboard/signals/widgets/signal_item.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/cupertino.dart';
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
              context.read<SignalsBloc>().add(const SignalsEvent());
              return Future.value();
            },
            child: Column(
              children: [
                const CryptoTicker(),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.green,
                    ),
                    itemCount: state.signals.length + 5,
                    itemBuilder: (context, index) {
                      final signal = state.signals[0];
                      return Stack(
                        children: [
                          SignalItem(signal: signal),
                          Positioned.fill(
                            child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                child: ColoredBox(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: CupertinoButton(
                              onPressed: () async {
                                // if (!context
                                //     .read<AuthenticationRepository>()
                                //     .isEmailVerified) {
                                //   Sw8Dialog.showOkDialog(
                                //     context,
                                //     'Email not verified',
                                //     'Only verified email addresses can purchase signals',
                                //   );
                                // }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.lock_open_outlined,
                                    color: Colors.green,
                                    size: 34,
                                  ),
                                  const SizedBox(height: 9),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.green.withOpacity(0.2),
                                    ),
                                    child: Text(
                                      'Unlock ₱${signal.price}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(height: 9),
                                  Text(
                                    '${signal.type.toUpperCase()} Signal',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
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
