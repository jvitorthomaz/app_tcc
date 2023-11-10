import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';

Future<dynamic>showConfirmationDialog(BuildContext context, {
  required bool isDeleteDialog,
  String title = "Atenção!",
  String content = "Você deseja realmente executar essa operação?",
  String affirmativeOption = "Confirmar",
}){
  return showDialog(
    context: context,
    builder: ((context) {
      return AlertDialog(
        title: Text(
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
