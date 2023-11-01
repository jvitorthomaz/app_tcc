import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/app_theme.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/features/auth/login/login_page.dart';
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
          routes: {
            '/':(_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/home/admUser': (_) => const Text('Adm'),
            '/home/employeeUser': (_) => const Text('Employee'),
          },
        );
      }
    );
  }
}