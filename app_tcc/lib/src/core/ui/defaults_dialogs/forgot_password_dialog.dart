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

        );
  }
}