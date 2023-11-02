import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/ui/helpers/forms_helper.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/features/auth/register/user_register_vm.dart';
import 'package:validatorless/validatorless.dart';

class UserRegisterPage extends ConsumerStatefulWidget {

  const UserRegisterPage({ super.key });

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  // final cpfEC = TextEditingController();
  // final celularEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    // cpfEC.dispose();
    // celularEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final userRegisterVm = ref.watch(userRegisterVmProvider.notifier);

    ref.listen(userRegisterVmProvider, (_, state) {
      switch (state) {
        case UserRegisterStateStatus.initial:
          break;
        case UserRegisterStateStatus.success:
          print('----------------\n----------------\nEntrou no case\n--------------\n--------------');
          Navigator.of(context).pushNamed('/auth/register/place',);
          //Navigator.of(context).pushNamedAndRemoveUntil('/auth/register/place', (route) => false);

        case UserRegisterStateStatus.error:
          MessagesHelper.showErrorSnackBar(
            'Erro ao registrar usuário do tipo administrador', 
            context
          );
      }

    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar nova conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
          
                const SizedBox(
                    height: 20,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: nameEC,
                  validator: Validatorless.required('O Nome é obrigatório'),
                  decoration: InputDecoration(
                    label: Text('Nome')
                  ),
                ),
          
                // const SizedBox(
                //   height: 25,
                // ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     label: Text('CPF')
                //   ),
                // ),
          
                // const SizedBox(
                //   height: 25,
                // ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     label: Text('Numero do Celular')
                //   ),
                // ),
          
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('O E-mail é obrigatório'),
                    Validatorless.email('O E-mail digitado é inválido')
                  ]),
                  decoration: InputDecoration(
                    label: Text('E-mail')
                  ),
                ),

          
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: passwordEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('A senha é obrigatória'),
                    Validatorless.min(6, 'A Senha deve conter no mínimo 6 caracteres'),
                  ]),
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text('Senha')
                  ),
                ),
          
                const SizedBox(
                height: 25,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  validator: Validatorless.multiple([
                    Validatorless.required('Confirmar a senha é obrigatório'),
                    Validatorless.compare(
                      passwordEC, 'As senhas digitadas são diferentes'
                    ),
                  ]),
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text('Confirmar Senha')
                  ),
                ),
          
                const SizedBox(
                    height: 25,
                ),
          
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(55)
                  ),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case null || false:
                        MessagesHelper.showErrorSnackBar('Formulário inválido', context);
                        
                      case true:
                        userRegisterVm.register(
                          name: nameEC.text,
                          email: emailEC.text,
                          password: passwordEC.text
                        );
                    }
                  },
                  child: const Text('CADASTRAR'),
                )
          
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
