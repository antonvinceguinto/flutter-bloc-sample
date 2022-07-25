import 'package:bloc_vgv_todoapp/core/blocs/app/app_bloc.dart';
import 'package:bloc_vgv_todoapp/features/login/view/login_page.dart';
import 'package:bloc_vgv_todoapp/features/signup/view/signup_page.dart';
import 'package:bloc_vgv_todoapp/features/todo/view/todo_page.dart';
import 'package:flutter/material.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [TodoPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case '/sign-up':
      return MaterialPageRoute(builder: (_) => const SignupPage());
    default:
      return MaterialPageRoute(builder: (_) => const LoginPage());
  }
}
