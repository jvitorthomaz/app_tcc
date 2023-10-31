import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      //Tirar imagem e deixar cor de fundo igual ã da tela de login
      //backgroundColor: Colors.black,
      body: 
      // DecoratedBox(
      //   decoration: const BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage(
      //         'assets/images/background_image_chair.jpg',
      //       ),
      //       opacity: 0.2,
      //       fit: BoxFit.cover,
      //     )
      //   ),
      // child: 
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          //.all(30.0),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/imgLogo.png'),
                        //Image.asset('assets/images/img_logo.png'),
                        const SizedBox(
                           height: 30,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('E-mail'),
                            hintText: 'E-mail',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),  
                        const SizedBox(
                           height: 20,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Senha'),
                            hintText: 'Senha',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                           height: 15,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Esqueceu a senha?', 
                            style: TextStyle(fontSize: 14, color: AppColors.colorBlack),
                          )
                        ),

                        const SizedBox(
                           height: 24,
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(55),
                          ),
                          onPressed: (){

                          }, 
                          child: Text('ACESSAR'),
                        )
                      ],
                    ),
                    const Align(
                      alignment: Alignment.bottomCenter,
                    
                      child: Text(
                        'Criar conta', 
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.colorBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ),
                  ],
                )
              )
            ],
          ),
        )
      //),
    );
  }
}