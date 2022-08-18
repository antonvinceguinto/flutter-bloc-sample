import 'package:bloc_vgv_todoapp/core/blocs/app/app_bloc.dart';
import 'package:bloc_vgv_todoapp/features/auth/auth_screens.dart';
import 'package:bloc_vgv_todoapp/features/dashboard/tab_manager/view/tab_manager.dart';
import 'package:flutter/material.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [TabManagerPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
