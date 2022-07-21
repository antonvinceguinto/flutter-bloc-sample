import 'package:bloc_vgv_todoapp/core/blocs/app/app_bloc.dart';
import 'package:bloc_vgv_todoapp/features/login/view/login_page.dart';
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
