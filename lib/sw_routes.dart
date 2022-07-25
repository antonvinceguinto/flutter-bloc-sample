import 'package:auto_route/auto_route.dart';
import 'package:bloc_vgv_todoapp/app/view/app.dart';
import 'package:bloc_vgv_todoapp/features/auth/forgot_password/forgot_password_page.dart';
import 'package:bloc_vgv_todoapp/features/auth/login/login_page.dart';
import 'package:bloc_vgv_todoapp/features/auth/signup/signup_page.dart';
import 'package:bloc_vgv_todoapp/features/todo/view/todo_page.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: AppInitView, initial: true),
    AutoRoute(page: LoginPage),
    AutoRoute(page: SignupPage),
    AutoRoute(page: TodoPage),
    AutoRoute(page: ForgotPasswordPage),
  ],
)
class $SWRouter {}
