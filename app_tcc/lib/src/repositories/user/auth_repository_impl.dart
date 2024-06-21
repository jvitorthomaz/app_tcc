import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/repositories/user/auth_repository.dart';

class AuthRepositoryImpl {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Fazer Update User
  Future<String?> redefinicaoSenha({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return "E-mail não cadastrado.";
      }
      return e.code;
    }
    return null;
  }

  @override
  Future<Either<RepositoryException, Nil>> updateUserProfileFirebase(
    String name, String email, String password) async {

      try {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: _firebaseAuth.currentUser!.email!,
          password: password,
        );

        final currentUser = FirebaseAuth.instance.currentUser;
        await currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
                email: currentUser.email!,
                password: password,
            ),
        );

              await currentUser?.updateDisplayName(name);
              await currentUser?.updateEmail(email);
              await currentUser?.reauthenticateWithCredential(
                EmailAuthProvider.credential(
                    email: currentUser.email!,
                    password: password,
                ),
              );

              return Success(nil);


        
      } on FirebaseAuthException catch (e, s) {
      
      log(
        'Erro ao alterar senha de usuário: ${e.code}',
        error: e, 
        stackTrace: s
      );
      return Failure(
        RepositoryException(
          message: 'Erro ao alterar senha de usuário: ${e.code}'
        )
      );
    }
  } 


  Future<String?> removerConta({required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: _firebaseAuth.currentUser!.email!,
        password: senha,
      );
      await _firebaseAuth.currentUser!.delete();
      
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }
}