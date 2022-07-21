import 'package:bloc_vgv_todoapp/core/api/auth_repository.dart';
import 'package:bloc_vgv_todoapp/features/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<dynamic> page() => const MaterialPage(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(context.read<AuthRepository>()),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (BuildContext context, state) {
          if (state.status == LoginStatus.error) {
            // Error handling
          }
        },
        child: Center(
          child: BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              if (state.status == LoginStatus.submitting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                child: const Text('Login via Gmail'),
                onPressed: () => context.read<LoginCubit>().loginWithGmail(),
              );
            },
          ),
        ),
      ),
    );
  }
}
