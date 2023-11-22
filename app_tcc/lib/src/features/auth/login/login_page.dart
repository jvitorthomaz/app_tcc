import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/defaults_snackbar/show_snackbar.dart';
import 'package:tcc_app/src/core/ui/helpers/forms_helper.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/features/auth/login/login_state.dart';
import 'package:tcc_app/src/features/auth/login/login_vm.dart';
import 'package:tcc_app/src/repositories/user/auth_repository_impl.dart';
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

  AuthRepositoryImpl authRepository = AuthRepositoryImpl();

  @override
  void dispose(){
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    //notifier é a view model, é a classe
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                             height: 5,
                          ),
                          const Text(
                            'MyClinic App', 
                            style: TextStyle(
                              color: AppColors.colorGreenLight, 
                              fontSize: 30, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(
                             height: 15,
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
                             height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //  InkWell(
                              //   onTap: () {
                              //     handleForgotPassword(height, width);
                              //   },
                              //   child: const Text(
                              //     'Redefinir senha', 
                              //     style: TextStyle(fontSize: 12, color: AppColors.colorBlack),
                              //   ),
                              // ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/auth/register/user');
                                },
                                child: const Text(
                                  'Criar nova conta', 
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.colorBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
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

  handleForgotPassword(height, width) {

    // return Theme(
    //       data: ThemeData(dialogBackgroundColor: Colors.white),
    String email = emailEC.text;
    
    return showDialog(
      context: context,
      builder: (context) {
        TextEditingController redefincaoSenhaController =
          TextEditingController(text: email);
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          child: AlertDialog(
            insetPadding: EdgeInsets.all(10),
            backgroundColor:Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Redefinição de senha",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.colorBlack,
                  ),
                ),
                IconButton(onPressed:() {Navigator.pop(context);}, icon: const Icon(Icons.close,color: AppColors.colorBlack))
              ],
            ),
            content: SizedBox(
              //width: 300,
              height: 70,
              width: width *0.9,
              child: Column(
                children: [
                  const SizedBox(
                     height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.colorBlack,
                    ),
                    controller: redefincaoSenhaController,
                    decoration: const InputDecoration(
                      label: Text("Confirme seu e-mail"),
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            actions: [
              Column(
                children: [
                  const SizedBox(
                     height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                    onPressed: (){
                        authRepository
                          .redefinicaoSenha(email: redefincaoSenhaController.text)
                          .then((String? erro) {
        
                        if (erro == null) {
                          showSnackBar(
                            context: context,
                            mensagem: "E-mail de redefinição enviado!",
                            isErro: false,
                          );
        
                        } else {
                          showSnackBar(context: context, mensagem: erro);
                        }
        
                        Navigator.pop(context);
                      });
                     
        
                    }, 
                    child: Text(
                    'Redefinir Senha', style: TextStyle(
                        fontSize: 16,)
                    
                    ),
                  ),
                  const SizedBox(
                     height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      authRepository
                          .redefinicaoSenha(email: redefincaoSenhaController.text)
                          .then((String? erro) {
                        if (erro == null) {
                          showSnackBar(
                            context: context,
                            mensagem: "E-mail de redefinição enviado!",
                            isErro: false,
                          );
                        } else {
                          showSnackBar(context: context, mensagem: erro);
                        }
        
                        Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      "Voltar",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.colorBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        
      },
    );   
  }
}
