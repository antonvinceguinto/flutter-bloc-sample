// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import 'app/view/app.dart' as _i1;
import 'features/auth/forgot_password/forgot_password_page.dart' as _i5;
import 'features/auth/login/login_page.dart' as _i2;
import 'features/auth/signup/signup_page.dart' as _i3;
import 'features/todo/view/todo_page.dart' as _i4;

class SWRouter extends _i6.RootStackRouter {
  SWRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AppInitView.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i1.AppInitView());
    },
    LoginRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginPage());
    },
    SignupRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i3.SignupPage());
    },
    TodoRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i4.TodoPage());
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i5.ForgotPasswordPage());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(AppInitView.name, path: '/'),
        _i6.RouteConfig(LoginRoute.name, path: '/login-page'),
        _i6.RouteConfig(SignupRoute.name, path: '/signup-page'),
        _i6.RouteConfig(TodoRoute.name, path: '/todo-page'),
        _i6.RouteConfig(ForgotPasswordRoute.name, path: '/forgot-password-page')
      ];
}

/// generated route for
/// [_i1.AppInitView]
class AppInitView extends _i6.PageRouteInfo<void> {
  const AppInitView() : super(AppInitView.name, path: '/');

  static const String name = 'AppInitView';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login-page');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.SignupPage]
class SignupRoute extends _i6.PageRouteInfo<void> {
  const SignupRoute() : super(SignupRoute.name, path: '/signup-page');

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i4.TodoPage]
class TodoRoute extends _i6.PageRouteInfo<void> {
  const TodoRoute() : super(TodoRoute.name, path: '/todo-page');

  static const String name = 'TodoRoute';
}

/// generated route for
/// [_i5.ForgotPasswordPage]
class ForgotPasswordRoute extends _i6.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(ForgotPasswordRoute.name, path: '/forgot-password-page');

  static const String name = 'ForgotPasswordRoute';
}
