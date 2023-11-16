import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/defaults_snackbar/show_snackbar.dart';
import 'package:tcc_app/src/repositories/user/auth_repository_impl.dart';

class ForgotPasswordDialog extends StatefulWidget {

 

  const ForgotPasswordDialog({ super.key });

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  AuthRepositoryImpl authRepository = AuthRepositoryImpl();

   @override
   Widget build(BuildContext context) {
       return const AlertDialog(
        //   backgroundColor:Colors.white,
        //   title: const Text(
        //     "Redefinição de senha",
        //     style: TextStyle(
        //       fontSize: 16,
        //       color: AppColors.colorBlack,
        //     ),
        //   ),
        //   content: SizedBox(
        //     width: MediaQuery.of(context).size.width*1,
        //     child: TextFormField(
        //       style: TextStyle(
        //         fontSize: 16,
        //         color: AppColors.colorBlack,
        //       ),
        //       controller: redefincaoSenhaController,
        //       decoration: const InputDecoration(
        //         label: Text("Confirme seu e-mail")
        //       ),
        //     ),
        //   ),
        //   shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(8))
        //   ),
        //   actions: [
        //     Column(
        //       children: [
        //         ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //             minimumSize: Size.fromHeight(50),
        //           ),
        //           onPressed: (){
        //               authRepository
        //                 .redefinicaoSenha(email: redefincaoSenhaController.text)
        //                 .then((String? erro) {

        //               if (erro == null) {
        //                 showSnackBar(
        //                   context: context,
        //                   mensagem: "E-mail de redefinição enviado!",
        //                   isErro: false,
        //                 );

        //               } else {
        //                 showSnackBar(context: context, mensagem: erro);
        //               }

        //               Navigator.pop(context);
        //             });
                   

        //           }, 
        //           child: Text(
        //           'Redefinir Senha', style: TextStyle(
        //               fontSize: 16,)
                  
        //           ),
        //         ),
        //         TextButton(
        //           onPressed: () {
        //             authRepository
        //                 .redefinicaoSenha(email: redefincaoSenhaController.text)
        //                 .then((String? erro) {
        //               if (erro == null) {
        //                 showSnackBar(
        //                   context: context,
        //                   mensagem: "E-mail de redefinição enviado!",
        //                   isErro: false,
        //                 );
        //               } else {
        //                 showSnackBar(context: context, mensagem: erro);
        //               }

        //               Navigator.pop(context);
        //             });
        //           },
        //           child: const Text(
        //             "Redefinir senha",
        //             style: TextStyle(
        //               fontSize: 16,
        //               color: AppColors.colorGreen,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        );
  }
}