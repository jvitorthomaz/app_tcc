import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/app_nav_global_key.dart';
import 'package:tcc_app/src/core/ui/app_theme.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/features/auth/login/login_page.dart';
import 'package:tcc_app/src/features/auth/register/register_clinic/place_register_page.dart';
import 'package:tcc_app/src/features/auth/register/register_user/user_register_page.dart';
import 'package:tcc_app/src/features/employee/register/employee_register_page.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_page.dart';
import 'package:tcc_app/src/features/splash/splash_page.dart';

class AppWidget extends StatelessWidget {

  const AppWidget({ super.key });

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const AppLoader(),
      builder: (AsyncNavigatorObserver){
        return MaterialApp(
          title: 'App',
          theme: AppTheme.themeData,

          navigatorObservers: [AsyncNavigatorObserver],
          navigatorKey: AppNavGlobalKey.instance.navKey,

          routes: {
            '/':(_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/auth/register/user': (_) => const UserRegisterPage(),
            '/auth/register/place': (_) => const PlaceRegisterPage(),
            '/home/admUser': (_) => const HomeAdmPage(),
            '/home/employeeUser': (_) => const Text('Employee'),
            '/employee/registerEmployee':(_) => const EmployeeRegisterPage(),
          },
        );
      }
    );
  }
}
