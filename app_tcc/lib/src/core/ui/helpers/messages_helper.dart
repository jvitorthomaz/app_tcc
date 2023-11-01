import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

sealed class MessagesHelper {
  static void showSuccessSnackBar(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(message: message),
    );
  } 

  static void showInfoSnackBar(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(message: message),
    );
  }

  static void showErrorSnackBar(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(message: message),
    );
  }

}

// extension MessagesHelper on BuildContext {
//   void showErrorSnackBar(String message) =>
//       _showCommonSnackBar(CustomSnackBar.error(message: message));

//   void showSuccessSnackBar(String message) =>
//       _showCommonSnackBar(CustomSnackBar.success(message: message));

//   void showInfoSnackBar(String message) =>
//       _showCommonSnackBar(CustomSnackBar.info(message: message));

//   void _showCommonSnackBar(Widget child) =>
//       showTopSnackBar(Overlay.of(this), child);
// }