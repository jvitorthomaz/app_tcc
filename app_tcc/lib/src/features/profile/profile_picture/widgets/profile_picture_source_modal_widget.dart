

import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';

Future<bool?>showSourceModalWidget({required BuildContext context}) {
  return showModalBottomSheet(
    context: context, 
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Container(
        height: 128,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: (){
                Navigator.pop(context, false);
              }, 
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt, 
                    size: 42,
                    color: AppColors.colorGreen,
                  ),
                  Text('Câmera', style: TextStyle(fontSize: 18, color: AppColors.colorGreen),)
                ],
              )
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context, true);
              }, 
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image, 
                    size: 42,
                    color: AppColors.colorGreen,
                  ),
                  Text('Galeria', style: TextStyle(fontSize: 18, color: AppColors.colorGreen),)
                ],
              )
            )
          ],
        ),
      );
    }
  );
}
