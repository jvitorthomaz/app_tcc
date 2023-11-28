import 'package:flutter/material.dart';
import 'package:tcc_app/src/repositories/user/auth_repository_impl.dart';

// showPasswordConfirmationDeleteDialog({
//   required BuildContext context,
//   required String email,
// }) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       TextEditingController senhaConfirmacaoController =
//           TextEditingController();
//       return AlertDialog(
//         title: Text("Deseja remover a conta com o e-mail $email?"),
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(32))
//         ),
//         content: SizedBox(
//           height: 120,
//           child: Column(
//             children: [
//               const Text(
//                 "Para confirmar a remoção da conta, insira sua senha:"
//               ),
//               TextFormField(
//                 controller: senhaConfirmacaoController,
//                 obscureText: true,
//                 decoration: const InputDecoration(label: Text("Senha")),
//               )
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {

//               AuthRepositoryImpl()
//                 .removerConta(senha: senhaConfirmacaoController.text)
//                 .then((String? erro) {
//                 if (erro == null) {
//                   Navigator.pop(context);
//                 }
//               });
              
//             },
//             child: const Text("EXCLUIR CONTA"),
//           )
//         ],
//       );
//     },
//   );
// }