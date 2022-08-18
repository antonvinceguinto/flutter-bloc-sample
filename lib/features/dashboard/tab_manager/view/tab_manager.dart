import 'package:authentication_repository/authentication_repository.dart';
import 'package:badges/badges.dart';
import 'package:bloc_vgv_todoapp/core/utils/helpers.dart';
import 'package:bloc_vgv_todoapp/features/dashboard/signals/view/signals_view.dart';
import 'package:bloc_vgv_todoapp/features/dashboard/tab_manager/cubit/index_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabManagerPage extends StatelessWidget {
  const TabManagerPage({super.key});

  static Page<dynamic> page() => const MaterialPage(child: TabManagerPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IndexCubit>(
      create: (_) => IndexCubit(),
      child: const TabManagerView(),
    );
  }
}

class TabManagerView extends StatelessWidget {
  const TabManagerView({super.key});

  static const List<Widget> _pages = <Widget>[
    SignalsPage(),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  static const verificationStatusHeight = 30.0;

  @override
  Widget build(BuildContext context) {
    final indexCubit = context.read<IndexCubit>();
    final _isEmailVerified =
        context.read<AuthenticationRepository>().isEmailVerified;

    return Scaffold(
      appBar: AppBar(
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
                  color: Colors.amber.shade300,
                  child: Center(
                    child: Text(
                      'Please check your email to verify your account',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                ),
        ),
        title: const Text('SW8 Signals'),
        // leading: IconButton(
        //   onPressed: () => context.read<AppBloc>().add(
        //         AppLogoutRequested(),
        //       ),
        //   icon: const Icon(
        //     Icons.exit_to_app,
        //     color: Colors.red,
        //   ),
        // ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '200 SC',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<IndexCubit, IndexState>(
        buildWhen: (previous, current) =>
            previous.currentIndex != current.currentIndex,
        builder: (context, state) {
          return SizedBox(
            height: kBottomNavigationBarHeight,
            child: Column(
              children: [
                const Divider(height: 1),
                Expanded(
                  child: BottomNavigationBar(
                    currentIndex: indexCubit.state.currentIndex,
                    onTap: (i) {
                      if (i != 0) {
                        return Sw8Dialog.showOkDialog(
                          context,
                          'Coming Soon',
                          'This feature will be open soon',
                        );
                      }
                    },
                    backgroundColor: Colors.black,
                    selectedItemColor: Colors.green,
                    unselectedItemColor: Colors.grey,
                    type: BottomNavigationBarType.fixed,
                    enableFeedback: true,
                    selectedFontSize: 12,
                    items: <BottomNavigationBarItem>[
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Badge(
                          badgeContent: const Icon(
                            Icons.lock,
                            color: Colors.red,
                            size: 19,
                          ),
                          badgeColor: Colors.transparent,
                          child: const Icon(Icons.whatshot_outlined),
                        ),
                        label: 'Hot',
                      ),
                      BottomNavigationBarItem(
                        icon: Badge(
                          badgeContent: const Icon(
                            Icons.lock,
                            color: Colors.red,
                            size: 19,
                          ),
                          badgeColor: Colors.transparent,
                          child: const Icon(Icons.account_circle_outlined),
                        ),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      body: BlocBuilder<IndexCubit, IndexState>(
        buildWhen: (previous, current) =>
            previous.currentIndex != current.currentIndex,
        builder: (context, state) {
          return Center(
            child:
                _pages.elementAt(context.read<IndexCubit>().state.currentIndex),
          );
        },
      ),
    );
  }
}

TextStyle get navItemLabelStyle => const TextStyle(
      fontSize: 12,
    );
