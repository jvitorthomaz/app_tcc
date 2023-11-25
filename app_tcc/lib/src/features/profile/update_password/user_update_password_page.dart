import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/ui/defaults_snackbar/show_snackbar.dart';
import 'package:tcc_app/src/core/ui/helpers/forms_helper.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/features/auth/register/register_user/user_register_vm.dart';
import 'package:tcc_app/src/features/profile/update_password/user_update_password_vm.dart';
import 'package:validatorless/validatorless.dart';

class UserUpdatePasswordPage extends ConsumerStatefulWidget {

  const UserUpdatePasswordPage({ super.key });

  @override
  ConsumerState<UserUpdatePasswordPage> createState() => _UserUpdatePasswordPageState();
}

class _UserUpdatePasswordPageState extends ConsumerState<UserUpdatePasswordPage> {

  final formKey = GlobalKey<FormState>();
  final oldPasswordEC = TextEditingController();
  //final emailEC = TextEditingController();
  final newPasswordEC = TextEditingController();
  // final cpfEC = TextEditingController();
  // final celularEC = TextEditingController();

  @override
  void dispose() {
    // nameEC.dispose();
    oldPasswordEC.dispose();
    newPasswordEC.dispose();
    // cpfEC.dispose();
    // celularEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final userUpdatePasswordVm = ref.watch(userUpdatePasswordVmProvider.notifier);

    ref.listen(userUpdatePasswordVmProvider, (_, state) {
      switch (state) {
        case UserUpdatePasswordStateStatus.initial:
          break;
        case UserUpdatePasswordStateStatus.success:
          print('----------------\n----------------\nEntrou no case\n--------------\n--------------');
            showSnackBar(
              context: context,
              mensagem: "Senha alterada com sucesso!",
              isErro: false,
            );
          Navigator.of(context).pop();
          //Navigator.of(context).pushNamedAndRemoveUntil('/auth/register/place', (route) => false);

        case UserUpdatePasswordStateStatus.error:
          MessagesHelper.showErrorSnackBar(
            'Houve um erro! Verifique os campos digitados.', 
            context
          );
      }

    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar senha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),

                Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Digite sua senha atual:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                       height: 5,
                    ),
                    TextFormField(
                      onTapOutside: (_) => context.unfocus(),
                      controller: oldPasswordEC,
                      validator: Validatorless.multiple([
                        Validatorless.required('A senha é obrigatória'),
                        Validatorless.min(6, 'A Senha deve conter no mínimo 6 caracteres'),
                      ]),
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text('Senha atual')
                      ),
                    ),
                  ],
                ),
          
                const SizedBox(
                  height: 25,
                ),

                Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Digite sua nova senha:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                       height: 5,
                    ),
                    TextFormField(
                      onTapOutside: (_) => context.unfocus(),
                      controller: newPasswordEC,
                      validator: Validatorless.multiple([
                        Validatorless.required('A senha é obrigatória'),
                        Validatorless.min(6, 'A Senha deve conter no mínimo 6 caracteres'),
                      ]),
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text('Nova senha')
                      ),
                    ),
                  ],
                ),
          
                const SizedBox(
                height: 25,
                ),


                Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'confirme sua nova senha:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                       height: 5,
                    ),
                    TextFormField(
                      onTapOutside: (_) => context.unfocus(),
                      validator: Validatorless.multiple([
                        Validatorless.required('Confirmar a senha é obrigatório'),
                        Validatorless.compare(
                          newPasswordEC, 'As senhas digitadas são diferentes'
                        ),
                      ]),
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text('Confirmar nova senha')
                      ),
                    ),
                  ],
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
                        userUpdatePasswordVm.updateLoggedUserPassword(
                          oldPassword: oldPasswordEC.text,
                          newPassword: newPasswordEC.text
                        );
                    }
                  },
                  child: const Text('ALTERAR SENHA'),
                )
          
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
