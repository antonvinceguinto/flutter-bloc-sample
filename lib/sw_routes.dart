import 'package:auto_route/auto_route.dart';
import 'package:bloc_vgv_todoapp/app/view/app.dart';
import 'package:bloc_vgv_todoapp/features/login/view/login_page.dart';
import 'package:bloc_vgv_todoapp/features/signup/view/signup_page.dart';
import 'package:bloc_vgv_todoapp/features/todo/view/todo_page.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: AppInitView, initial: true),
    AutoRoute(page: LoginPage),
    AutoRoute(page: SignupPage),
    AutoRoute(page: TodoPage),
  ],
)
class $SWRouter {}
