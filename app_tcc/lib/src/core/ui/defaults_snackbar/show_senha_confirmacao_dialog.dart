// import 'package:flutter/material.dart';
// import 'package:my_clinic_app/src/services/user_login_services/user_login_service.dart';

// showSenhaConfirmacaoDialog({
//   required BuildContext context,
//   required String email,
// }) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       TextEditingController senhaConfirmacaoController =
//           TextEditingController();
//       final UserLoginService userLoginService;
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
//                   "Para confirmar a remoção da conta, insira sua senha:"),
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
//               AuthService()
//                   .removerConta(senha: senhaConfirmacaoController.text)
//                   .then((String? erro) {
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
