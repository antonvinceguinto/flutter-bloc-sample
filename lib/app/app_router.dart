import 'package:auto_route/auto_route.dart';
import 'package:bloc_vgv_todoapp/app/app.dart';
import 'package:bloc_vgv_todoapp/features/auth/auth_screens.dart';
import 'package:bloc_vgv_todoapp/features/signals/view/signals_view.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: AppInitView, initial: true),
    AutoRoute(page: LoginPage),
    AutoRoute(page: SignupPage),
    AutoRoute(page: SignalsPage),
    AutoRoute(page: ForgotPasswordPage),
  ],
)
class $AppRouter {}
