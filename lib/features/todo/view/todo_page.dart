import 'package:bloc_vgv_todoapp/core/blocs/app/app_bloc.dart';
import 'package:bloc_vgv_todoapp/features/todo/cubit/todo_cubit.dart';
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

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final todosState = context.select((TodoCubit cubit) => cubit.state);
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        leading: IconButton(
          onPressed: () => context.read<AppBloc>().add(
                AppLogoutRequested(),
              ),
          icon: const Icon(Icons.exit_to_app),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.avatar!),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context
            .read<TodoCubit>()
            .add('Test ${DateTime.now().minute}:${DateTime.now().second}'),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TODO(antonguinto): Make widget reusable
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Pending'),
                ),
                ...todosState.map(
                  (todo) => !todo.completed
                      ? ListTile(
                          title: Text(
                            todo.title!,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          leading: Checkbox(
                            value: todo.completed,
                            onChanged: (value) =>
                                context.read<TodoCubit>().toggle(todo.id!),
                          ),
                          trailing: IconButton(
                            onPressed: () =>
                                context.read<TodoCubit>().remove(todo.id!),
                            icon: const Icon(Icons.delete),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Completed'),
                ),
                ...todosState.map(
                  (todo) => todo.completed
                      ? ListTile(
                          title: Text(
                            todo.title!,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                          ),
                          leading: Checkbox(
                            value: todo.completed,
                            onChanged: (value) =>
                                context.read<TodoCubit>().toggle(todo.id!),
                          ),
                          trailing: IconButton(
                            onPressed: () =>
                                context.read<TodoCubit>().remove(todo.id!),
                            icon: const Icon(Icons.delete),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
