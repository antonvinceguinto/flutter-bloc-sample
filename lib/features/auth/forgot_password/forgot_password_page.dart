import 'package:authentication_repository/authentication_repository.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bloc_vgv_todoapp/features/auth/cubit/login_cubit.dart';
import 'package:bloc_vgv_todoapp/features/auth/widgets/bloc_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
      child: ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (BuildContext context, state) {
          late BuildContext dialogContext;

          if (state.status == LoginStatus.error) {
            showDialog<void>(
              context: context,
              builder: (context) {
                dialogContext = context;
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.error),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }

          if (state.status == LoginStatus.success) {
            showDialog<void>(
              context: context,
              builder: (context) {
                dialogContext = context;
                return AlertDialog(
                  title: const Text('Success'),
                  content: const Text(
                    'Please check your email for instructions on how to reset your password',
                  ),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        AutoRouter.of(context).popUntil(
                          (route) => route.isFirst,
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 8,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forgot Password?',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Don't worry, we'll send you an email with instructions to reset your password.",
                ),
                const SizedBox(height: 36),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocLoginWrapper(
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            decoration: customInputDecoration(
                              labelText: 'Email',
                              icon: Icons.alternate_email,
                            ),
                            onChanged: (value) =>
                                context.read<LoginCubit>().emailChanged(value),
                            validator: (value) => value!.trim().isEmpty
                                ? "Email can't be empty"
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      BlocBuilder<LoginCubit, LoginState>(
                        buildWhen: (previous, current) =>
                            previous.status != current.status,
                        builder: (context, state) {
                          return state.status == LoginStatus.submitting
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: const Text('Submit'),
                                    onPressed: () async {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      await context
                                          .read<LoginCubit>()
                                          .forgotPassword();
                                    },
                                  ),
                                );
                        },
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        child: const Text('Go Back'),
                        onPressed: () async {
                          await AutoRouter.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
