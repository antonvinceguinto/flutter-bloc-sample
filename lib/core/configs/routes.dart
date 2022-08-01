import 'package:bloc_vgv_todoapp/core/blocs/app/app_bloc.dart';
import 'package:bloc_vgv_todoapp/features/auth/auth_screens.dart';
import 'package:bloc_vgv_todoapp/features/signals/view/signals_view.dart';
import 'package:flutter/material.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [SignalsPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
