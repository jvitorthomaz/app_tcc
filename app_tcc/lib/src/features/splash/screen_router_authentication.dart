import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcc_app/src/features/auth/login/login_page.dart';
import 'package:tcc_app/src/features/splash/splash_page.dart';

class ScreenRouterAuthentication extends StatelessWidget {

  const ScreenRouterAuthentication({ super.key });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (!snapshot.hasData) {
            return const SplashPage();
          } else {
            return const LoginPage();
          }
        }
      },
    );
      
  }
}