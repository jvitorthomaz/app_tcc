//import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/features/auth/login/login_page.dart';

class SplashPage extends StatefulWidget {

  const SplashPage({ super.key });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

/*
#fbf3f2;
#f5867e;
#fbb4b3;
#e6a4ac
#f8cec1;
*/


class _SplashPageState extends State<SplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;

  double get _logoAnimationWidth => 100 * _scale;
  double get _logoAnimationHeight => 120 * _scale;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1;
      });
    });
    super.initState();
  }

   @override
   Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        //Tirar imagem e deixar cor de fundo igual ã da tela de login
        // body: DecoratedBox(
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(
        //         AppImages.backgroundImage,
        //       ),
        //       opacity: 0.2,
        //       fit: BoxFit.cover,
        //     )
        //   ),
        //   child: 
          body: Center(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              opacity: _animationOpacityLogo,
              onEnd: () {
                Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                    settings: const RouteSettings(name: '/auth/login'),
                    pageBuilder: (
                      context, 
                      animation, 
                      secondaryAnimation,
                    ) {
                      return const LoginPage();
                    },
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(opacity: animation, child: child,);
                    }
                  ), (route) => false
                );
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 3),
                width: _logoAnimationWidth,
                height: _logoAnimationHeight,
                curve: Curves.linearToEaseOut,
                child: Image.asset(
                  AppImages.imgLogo,
                  fit: BoxFit.cover
                )
              )
            ),
          )
        //)
      );
  }
}