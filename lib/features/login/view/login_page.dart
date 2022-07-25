import 'package:auto_route/auto_route.dart';
import 'package:bloc_vgv_todoapp/core/blocs/app/app_bloc.dart';
import 'package:bloc_vgv_todoapp/core/repositories/auth_repository.dart';
import 'package:bloc_vgv_todoapp/features/login/cubit/login_cubit.dart';
import 'package:bloc_vgv_todoapp/sw_routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<dynamic> page() => const MaterialPage(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(context.read<AuthRepository>()),
      child: LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (BuildContext context, state) {
          if (state.status == LoginStatus.error) {
            late BuildContext dialogContext;

            showDialog<void>(
              context: context,
              builder: (context) {
                dialogContext = context;
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Please check your email and password'),
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
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 8,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 120,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Sw8 Signals',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Login',
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
                              onChanged: (value) => context
                                  .read<LoginCubit>()
                                  .emailChanged(value),
                              validator: (value) => value!.isEmpty
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
                              validator: (value) => value!.isEmpty
                                  ? "Password can't be empty"
                                  : null,
                              obscureText: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              child: const Text('Forgot Password'),
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<LoginCubit, LoginState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return state.status == LoginStatus.submitting
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      child: const Text('Login'),
                                      onPressed: () async {
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          return;
                                        }
                                        await context
                                            .read<LoginCubit>()
                                            .loginWithCredential();
                                      },
                                    ),
                                  );
                          },
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          child: const Text('Create Signal Account'),
                          onPressed: () async {
                            await AutoRouter.of(context)
                                .push(const SignupRoute());
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
