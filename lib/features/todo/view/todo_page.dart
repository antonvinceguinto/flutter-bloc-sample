import 'package:bloc_vgv_todoapp/core/blocs/app/app_bloc.dart';
import 'package:bloc_vgv_todoapp/core/repositories/auth_repository.dart';
import 'package:bloc_vgv_todoapp/features/todo/cubit/todo_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  static Page<dynamic> page() => const MaterialPage(child: TodoPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(),
      child: const TodoView(),
    );
  }
}

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
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
      body: RefreshIndicator(
        onRefresh: () {
          return Future.value();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
