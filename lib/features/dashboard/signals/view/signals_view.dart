import 'package:bloc_vgv_todoapp/features/dashboard/signals/bloc/signals_bloc.dart';
import 'package:bloc_vgv_todoapp/features/dashboard/signals/widgets/crypto_ticker.dart';
import 'package:bloc_vgv_todoapp/features/dashboard/signals/widgets/signal_item.dart';
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
    return Column(
      children: [
        const CryptoTicker(),
        const SizedBox(height: 8),
        Expanded(
          child: BlocBuilder<SignalsBloc, SignalsState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, SignalsState state) {
              if (state is SignalsLoaded) {
                return RefreshIndicator(
                  onRefresh: () {
                    context.read<SignalsBloc>().add(const SignalsEvent());
                    return Future.value();
                  },
                  child: Stack(
                    children: [
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.green,
                        ),
                        itemCount: state.signals.length + 5,
                        itemBuilder: (context, index) {
                          final signal = state.signals[0];
                          return SignalItem(signal: signal);
                        },
                      ),
                      // Positioned.fill(
                      //   child: ClipRect(
                      //     child: BackdropFilter(
                      //       filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      //       child: ColoredBox(
                      //         color: Colors.black.withOpacity(0.6),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const Positioned.fill(
                      //   child: SignalLock(),
                      // ),
                    ],
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
