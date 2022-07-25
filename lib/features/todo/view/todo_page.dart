import 'package:bloc_vgv_todoapp/core/blocs/app/app_bloc.dart';
import 'package:bloc_vgv_todoapp/features/todo/bloc/todo_bloc.dart';
import 'package:bloc_vgv_todoapp/features/todo/cubit/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  static Page<dynamic> page() => const MaterialPage(child: TodoPage());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TodoBloc(),
        ),
        // BlocProvider(
        //   create: (context) => TodoCubit(),
        // ),
      ],
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
  late TextEditingController _titleEditingController;
  late FocusNode _titleFocusNode;

  @override
  void dispose() {
    _titleEditingController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final todosState = context.select((TodoCubit cubit) => cubit.state);
    final todoBloc = context.select((TodoBloc bloc) => bloc.state);
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Todo',
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              child: ClipOval(
                child: Image.network(
                  user.avatar!,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_titleFocusNode.hasFocus) {
            context.read<TodoCubit>().add('');
          }
          Future.delayed(const Duration(milliseconds: 200), () {
            _titleFocusNode.requestFocus();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (BuildContext context, TodoState state) {
          print('listening to state: $state');
        },
        // buildWhen: (previous, current) => previous.props != current.props,
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (BuildContext context, TodoState state) {
            print('builder state: $state');
            if (state is TodoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Text('Hello');
          },
        ),
        // builder: (BuildContext context, TodoState state) {
        //   print('builder state: $state');
        //   if (state is TodoLoading) {
        //     return const Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   }
        //   if (state is TodoLoaded) {
        //     return RefreshIndicator(
        //       onRefresh: () {
        //         return Future.value();
        //       },
        //       child: Container(
        //         child: Text('Hello'),
        //       ),
        //       // child: SingleChildScrollView(
        //       //   child: Column(
        //       //     children: [
        //       //       ListView(
        //       //         shrinkWrap: true,
        //       //         physics: const NeverScrollableScrollPhysics(),
        //       //         children: [
        //       //           const Padding(
        //       //             padding: EdgeInsets.all(16),
        //       //             child: Text('Pending'),
        //       //           ),
        //       //           ...todosState.map(
        //       //             (todo) => !todo.completed
        //       //                 ? BlocBuilder(
        //       //                     bloc: context.read<TodoCubit>(),
        //       //                     buildWhen: (previous, current) =>
        //       //                         previous != current,
        //       //                     builder: (context, state) {
        //       //                       _titleEditingController =
        //       //                           TextEditingController(text: todo.title);
        //       //                       _titleFocusNode = FocusNode();

        //       //                       return ListTile(
        //       //                         key: Key(todo.id!),
        //       //                         title: EditableText(
        //       //                           controller: _titleEditingController,
        //       //                           textInputAction: TextInputAction.done,
        //       //                           minLines: 1,
        //       //                           maxLines: 3,
        //       //                           onSubmitted: (value) {
        //       //                             if (value.trim().isNotEmpty) {
        //       //                               context
        //       //                                   .read<TodoCubit>()
        //       //                                   .updateTodo(
        //       //                                     todo.id!,
        //       //                                     value,
        //       //                                   );
        //       //                             } else {
        //       //                               context
        //       //                                   .read<TodoCubit>()
        //       //                                   .remove(todo.id!);
        //       //                             }

        //       //                             _titleFocusNode.unfocus();
        //       //                           },
        //       //                           backgroundCursorColor: Colors.black,
        //       //                           cursorColor: Colors.red,
        //       //                           focusNode: _titleFocusNode,
        //       //                           style: const TextStyle(
        //       //                             color: Colors.black,
        //       //                           ),
        //       //                         ),
        //       //                         leading: Checkbox(
        //       //                           value: todo.completed,
        //       //                           onChanged: (value) => context
        //       //                               .read<TodoCubit>()
        //       //                               .toggle(todo.id!),
        //       //                         ),
        //       //                         trailing: IconButton(
        //       //                           onPressed: () => context
        //       //                               .read<TodoCubit>()
        //       //                               .remove(todo.id!),
        //       //                           icon: const Icon(Icons.delete),
        //       //                         ),
        //       //                       );
        //       //                     },
        //       //                   )
        //       //                 : Container(),
        //       //           ),
        //       //         ],
        //       //       ),
        //       //       ListView(
        //       //         shrinkWrap: true,
        //       //         physics: const NeverScrollableScrollPhysics(),
        //       //         children: [
        //       //           const Padding(
        //       //             padding: EdgeInsets.all(16),
        //       //             child: Text('Completed'),
        //       //           ),
        //       //           ...todosState.map(
        //       //             (todo) => todo.completed
        //       //                 ? ListTile(
        //       //                     title: Text(
        //       //                       todo.title!,
        //       //                       style: Theme.of(context)
        //       //                           .textTheme
        //       //                           .bodyText1!
        //       //                           .copyWith(
        //       //                             decoration:
        //       //                                 TextDecoration.lineThrough,
        //       //                           ),
        //       //                     ),
        //       //                     leading: Checkbox(
        //       //                       value: todo.completed,
        //       //                       onChanged: (value) => context
        //       //                           .read<TodoCubit>()
        //       //                           .toggle(todo.id!),
        //       //                     ),
        //       //                     trailing: IconButton(
        //       //                       onPressed: () => context
        //       //                           .read<TodoCubit>()
        //       //                           .remove(todo.id!),
        //       //                       icon: const Icon(Icons.delete),
        //       //                     ),
        //       //                   )
        //       //                 : Container(),
        //       //           ),
        //       //         ],
        //       //       ),
        //       //     ],
        //       //   ),
        //       // ),
        //     );
        //   }
        //   return const Center(
        //     child: Text('Unknown state'),
        //   );
        // },
      ),
    );
  }
}
