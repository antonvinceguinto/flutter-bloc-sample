import 'package:auto_route/auto_route.dart';
import 'package:bloc_vgv_todoapp/core/repositories/auth_repository.dart';
import 'package:bloc_vgv_todoapp/features/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(context.read<AuthRepository>()),
      child: SignupView(),
    );
  }
}

class SignupView extends StatelessWidget {
  SignupView({super.key});

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
                  content: const Text('Something went wrong'),
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
            Future.delayed(const Duration(milliseconds: 500), () async {
              await AutoRouter.of(context).pop();
            });
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
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Signup',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                ),
                const SizedBox(height: 22),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _blocBuilderWrapper(
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            decoration: _inputDecoration(
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
                      const SizedBox(height: 8),
                      _blocBuilderWrapper(
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            decoration: _inputDecoration(
                              labelText: 'Password',
                              icon: Icons.lock,
                            ),
                            onChanged: (value) => context
                                .read<LoginCubit>()
                                .passwordChanged(value),
                            validator: (value) => value!.trim().isEmpty
                                ? "Password can't be empty"
                                : value.length < 6
                                    ? 'Minimum of 6 characters'
                                    : null,
                            obscureText: true,
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
                                          .signupWithCredential();
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

Widget _blocBuilderWrapper({required Widget child}) {
  return BlocBuilder<LoginCubit, LoginState>(
    buildWhen: (previous, current) => previous.status != current.status,
    builder: (context, state) {
      return child;
    },
  );
}

InputDecoration _inputDecoration({
  required String labelText,
  required IconData icon,
}) {
  return InputDecoration(
    hintText: labelText,
    // fillColor: Colors.grey[100],
    // filled: true,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    icon: Icon(
      icon,
      color: Colors.blueGrey.shade400,
    ),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        width: 3,
        color: Colors.blueGrey.shade400,
      ),
    ),
  );
}
