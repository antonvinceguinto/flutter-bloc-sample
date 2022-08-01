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

import '../features/auth/auth_screens.dart' as _i2;
import '../features/signals/view/signals_view.dart' as _i3;
import 'app.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
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
          routeData: routeData, child: const _i2.SignupPage());
    },
    SignalsRoute.name: (routeData) {
      final args = routeData.argsAs<SignalsRouteArgs>(
          orElse: () => const SignalsRouteArgs());
      return _i4.CupertinoPageX<dynamic>(
          routeData: routeData, child: _i3.SignalsPage(key: args.key));
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i4.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i2.ForgotPasswordPage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(AppInitView.name, path: '/'),
        _i4.RouteConfig(LoginRoute.name, path: '/login-page'),
        _i4.RouteConfig(SignupRoute.name, path: '/signup-page'),
        _i4.RouteConfig(SignalsRoute.name, path: '/signals-page'),
        _i4.RouteConfig(ForgotPasswordRoute.name, path: '/forgot-password-page')
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
/// [_i2.SignupPage]
class SignupRoute extends _i4.PageRouteInfo<void> {
  const SignupRoute() : super(SignupRoute.name, path: '/signup-page');

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i3.SignalsPage]
class SignalsRoute extends _i4.PageRouteInfo<SignalsRouteArgs> {
  SignalsRoute({_i5.Key? key})
      : super(SignalsRoute.name,
            path: '/signals-page', args: SignalsRouteArgs(key: key));

  static const String name = 'SignalsRoute';
}

class SignalsRouteArgs {
  const SignalsRouteArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'SignalsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.ForgotPasswordPage]
class ForgotPasswordRoute extends _i4.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(ForgotPasswordRoute.name, path: '/forgot-password-page');

  static const String name = 'ForgotPasswordRoute';
}
