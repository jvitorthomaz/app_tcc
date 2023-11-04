//import 'package:asyncstate/asyncstate.dart';
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/features/auth/login/login_page.dart';
import 'package:tcc_app/src/features/splash/splash_page_vm.dart';

class SplashPage extends ConsumerStatefulWidget {

  const SplashPage({ super.key });

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

/*
#fbf3f2;
#f5867e;
#fbb4b3;
#e6a4ac
#f8cec1;
*/


class _SplashPageState extends ConsumerState<SplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;

  double get _logoAnimationWidth => 100 * _scale;
  double get _logoAnimationHeight => 120 * _scale;

  var endAnimation = false;

  Timer? redirectRouteTimer;

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

  void _redirectRoute(String routeName) {
    if(!endAnimation){
      redirectRouteTimer?.cancel();

      redirectRouteTimer = Timer(const Duration(milliseconds: 300), () {
        _redirectRoute(routeName);
      });

    } else{
      redirectRouteTimer?.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
    }
  }

   @override
  Widget build(BuildContext context) {

    ref.listen(splashPageVmProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          log('Erro ao Validar', error: error, stackTrace: stackTrace);

          MessagesHelper.showErrorSnackBar('Erro ao Validar o login', context);
          //Navigator.of(context).pushNamedAndRemoveUntil('/auth/login', (route) => false);
          _redirectRoute('/auth/login');
        },

        data: (data) {
          switch (data) {
            case SplashPageState.loggedAdm:
              //Navigator.of(context).pushNamedAndRemoveUntil('/home/admUser', (route) => false);
              _redirectRoute('/home/admUser');

            case SplashPageState.loggedEmployee:
              //Navigator.of(context).pushNamedAndRemoveUntil('/home/employeeUser', (route) => false);
              _redirectRoute('/home/employeeUser');

            case _:
              //Navigator.of(context).pushNamedAndRemoveUntil('/auth/login', (route) => false);
              _redirectRoute('/auth/login');
          }
        },
      );
    });
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
            duration: const Duration(seconds: 3),
            curve: Curves.easeIn,
            opacity: _animationOpacityLogo,
            onEnd: () {
              setState(() {
                endAnimation = true;
              });
              // Navigator.of(context).pushAndRemoveUntil(
              //   PageRouteBuilder(
              //     settings: const RouteSettings(name: '/auth/login'),
              //     pageBuilder: (
              //       context, 
              //       animation, 
              //       secondaryAnimation,
              //     ) {
              //       return const LoginPage();
              //     },
              //     transitionsBuilder: (_, animation, __, child) {
              //       return FadeTransition(opacity: animation, child: child,);
              //     }
              //   ), (route) => false
              // );
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