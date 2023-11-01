import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/helpers/forms_helper.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/features/auth/login/login_state.dart';
import 'package:tcc_app/src/features/auth/login/login_vm.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {

  const LoginPage({ super.key });

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  void dispose(){
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    //notifier é a view model, é a classe
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);

    // Provider é o estado
    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;

        case LoginState(status: LoginStateStatus.error, errorMessage: final errorMessage?):
          // context.showError(errorMessage);
          MessagesHelper.showErrorSnackBar(errorMessage, context);


        case LoginState(status: LoginStateStatus.error):
          // context.showError('Erro ao realizar login');
          MessagesHelper.showErrorSnackBar('Ocorreu um erro ao realizar a login', context);


        case LoginState(status: LoginStateStatus.admLogin):
          Navigator.of(context).pushNamedAndRemoveUntil('/home/admUser', (route) => false);
          break;

        case LoginState(status: LoginStateStatus.employeeLogin):
          Navigator.of(context).pushNamedAndRemoveUntil('/home/employeeUser', (route) => false);
          break;

      }
    });

    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      //Tirar imagem e deixar cor de fundo igual ã da tela de login
      //backgroundColor: Colors.black,
      body: 
      // DecoratedBox(
      //   decoration: const BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage(
      //         AppImages.backgroundImage,
      //       ),
      //       opacity: 0.2,
      //       fit: BoxFit.cover,
      //     )
      //   ),
      // child: 
        Form(
          key: formKey,
          child: Padding(
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
                          
                          Image.asset(
                            AppImages.imgLogo, 
                            width: 180, 
                            height: 180,
                          ),
                          const SizedBox(
                             height: 30,
                          ),


                          TextFormField(
                            onTapOutside: (_) => context.unfocus(),
                            validator: Validatorless.multiple([
                              Validatorless.required('O E-mail é obrigatório'),
                              Validatorless.email('O E-mail inserido é inválido'), 
                            ]),
                            controller: emailEC,
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
                            onTapOutside: (_) => context.unfocus(),
                             validator: Validatorless.multiple([
                              Validatorless.required('A Senha é obrigatória'),
                              Validatorless.min(6, 'A Senha deve conter pelo menos 6 caracteres'), 
                            ]),
                            obscureText: true,
                            controller: passwordEC,
                            decoration: const InputDecoration(
                              label: Text('Senha'),
                              hintText: 'Senha',
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          // const SizedBox(
                          //    height: 15,
                          // ),


                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     'Esqueceu a senha?', 
                          //     style: TextStyle(fontSize: 14, color: AppColors.colorBlack),
                          //   )
                          // ),
        
                          const SizedBox(
                             height: 24,
                          ),
        
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(55),
                            ),
                            onPressed: (){
                              switch (formKey.currentState?.validate()) {
                                case (false || null):
                                MessagesHelper.showErrorSnackBar('O Campos digitados estão inválidos', context);
                                  break;
                                case true:
                                  login(emailEC.text, passwordEC.text);
                              }
        
                            }, 
                            child: Text('ACESSAR'),
                          ),
        
                          const SizedBox(
                             height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                              'Recuperar senha', 
                              style: TextStyle(fontSize: 12, color: AppColors.colorBlack),
                            ),
                              Text(
                                'Criar conta', 
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.colorBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      // const Align(
                      //   alignment: Alignment.bottomCenter,
                      
                      //   child: Text(
                      //     'Criar conta', 
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       color: AppColors.colorBlack,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   )
                      // ),
                    ],
                  )
                )
              ],
            ),
          ),
        )
      //),
    );
  }
}