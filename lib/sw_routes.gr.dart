// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import 'app/view/app.dart' as _i1;
import 'features/login/view/login_page.dart' as _i2;
import 'features/signup/view/signup_page.dart' as _i3;

class SWRouter extends _i4.RootStackRouter {
  SWRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    AppInitView.name: (routeData) {
      return _i4.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i1.AppInitView());
    },
    LoginRoute.name: (routeData) {
      return _i4.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginPage());
    },
    SignupRoute.name: (routeData) {
      return _i4.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i3.SignupPage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(AppInitView.name, path: '/'),
        _i4.RouteConfig(LoginRoute.name, path: '/login-page'),
        _i4.RouteConfig(SignupRoute.name, path: '/signup-page')
      ];
}

/// generated route for
/// [_i1.AppInitView]
class AppInitView extends _i4.PageRouteInfo<void> {
  const AppInitView() : super(AppInitView.name, path: '/');

  static const String name = 'AppInitView';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login-page');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.SignupPage]
class SignupRoute extends _i4.PageRouteInfo<void> {
  const SignupRoute() : super(SignupRoute.name, path: '/signup-page');

  static const String name = 'SignupRoute';
}
