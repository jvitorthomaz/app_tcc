import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';

Future<dynamic>showDeleteEmployeeDialog(BuildContext context, {
  required bool isAdmUser,
  width ,
  height,
  String title = "Atenção!",
  String content = "Você deseja realmente executar essa operação?",
  String affirmativeOption = "Confirmar",
}){


  return isAdmUser ? 
   showDialog(
    context: context,
    builder: ((context) {
      return SizedBox(
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorRed,
                  ),
              ),
               IconButton(onPressed:() {Navigator.pop(context);}, icon: const Icon(Icons.close,color: AppColors.colorRed))
            ],
          ),
      
          content: const Text(
            "Você está tentando deletar sua própria conta!\n\nSe você realmente deseja fazer isso, acesse sua tela de perfil.",
          ),
              
          
      
          actions: [
      
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20)
                  ),
                  onPressed: () {
                     Navigator.pop(context, false);
                  },
                  child: const Text('VOLTAR'),
                ),
              ],
            ),
          ],
        ),
      );
    })
  ):
  showDialog(
    context: context,
    builder: ((context) {
      return SizedBox(
        
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorRed,
                  ),
              ),
               IconButton(onPressed:() {Navigator.pop(context);}, icon: const Icon(Icons.close,color: AppColors.colorRed))
            ],
          ),
      
          content: Text(
            content,
            textAlign: TextAlign.left
          ),
           
      
          actions: [
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20)
                  ),
                  onPressed: () {
                     Navigator.pop(context, false);
                  },
                  child: const Text('CENCELAR'),
                ),
      
                
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    backgroundColor: AppColors.colorRed,
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(
                     affirmativeOption.toUpperCase(),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    })
  );

      // :
      //       AlertDialog(
      //   title: Text(
      //     title,
      //     style: const TextStyle(
      //         fontSize: 18,
      //         color: AppColors.colorRed,
      //       ),
      //   ),

      //   content: const Column(
      //     children: [
      //       Text(
      //         "Você está tenatndo deletar sua própria conta!",
      //       ),
      //        Text(
      //         "Se você realmente deseja fazer isso, acesse sua tela de perfil.",
      //       ),
      //     ],
      //   ),

      //   actions: [

      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         OutlinedButton(
      //           style: ElevatedButton.styleFrom(
      //             padding: const EdgeInsets.symmetric(horizontal: 20)
      //           ),
      //           onPressed: () {
      //              Navigator.pop(context, false);
      //           },
      //           child: const Text('VOLTAR'),
      //         ),
      //       ],
      //     ),
      //   ],
      // )
}