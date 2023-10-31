import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
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
          navigatorObservers: [AsyncNavigatorObserver],
          routes: {
            '/':(_) => const SplashPage(),
          },
        );
      }
    );
  }
}