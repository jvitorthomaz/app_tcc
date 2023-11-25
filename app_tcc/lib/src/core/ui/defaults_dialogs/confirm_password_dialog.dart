import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';

Future<dynamic>showConfirmationPasswordDialog(BuildContext context, {
  required bool isDeleteDialog,
  String title = "Atenção!",
  String content = "Para atualizar seu perfil você deve confirmar sua senha no campo abaixo:",
  String affirmativeOption = "Confirmar",
}){
  return showDialog(
    context: context,
    builder: ((context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: isDeleteDialog 
              ? const TextStyle(
                  fontSize: 18,
                  color: AppColors.colorRed,
                )
              
              : const TextStyle(
                  fontSize: 18,
                  color: AppColors.colorGreen,
                ),
            ),
            IconButton(onPressed:() {Navigator.pop(context);}, icon: const Icon(Icons.close,color: AppColors.colorBlack))
          ],
        ),

        content: Text(
          content,
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

              isDeleteDialog ?
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
              )
              : 
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(
                   affirmativeOption.toUpperCase(),
                ),
              )
              ,
            ],
          ),
        ],
      );
    })
  );
}