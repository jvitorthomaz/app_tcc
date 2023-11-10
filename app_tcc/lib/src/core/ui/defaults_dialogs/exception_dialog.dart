import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';

showExceptionDialog(
  BuildContext context, {
  required String content,
  String title = "Um problema aconteceu",
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            const Icon(
              Icons.warning,
              color: AppColors.colorGreen,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
            ),
          ]
        ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "OK",
              style: TextStyle(
                color: AppColors.colorGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
    },
  );
}
