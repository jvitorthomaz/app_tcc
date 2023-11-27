import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/repositories/user/auth_repository.dart';

class AuthRepositoryImpl {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //   Future<Either<AuthException, String>> entrarUsuario({required String email, required String senha}) async {
  //   try {
  //     final credential = await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email, 
  //       password: senha
  //     );
  //     print(credential.user!.uid);

  //     return Success(credential.user!.uid);

  //   } on FirebaseAuthException catch (e) {
  //           switch (e.code) {
  //       case "user-not-found":
  //       return Failure(AuthError(message: 'O e-mail não está cadastrado.'));
          
  //       case "wrong-password":
  //       return Failure(AuthError(message: 'Senha incorreta.'));
  //     }
  //     return Failure(AuthError(message: e.code));

  //     // switch (e.code) {
  //     //   case "user-not-found":
  //     //     return "O e-mail não está cadastrado.";
  //     //   case "wrong-password":
  //     //     return "Senha incorreta.";
  //     // }
  //     // return e.code;

  //   }

  //   //return null;
  // }

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

        //final currentUser = _firebaseAuth.currentUser;

        final currentUser = FirebaseAuth.instance.currentUser;
        await currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
                email: currentUser.email!,
                password: password,
            ),
        );

        //      final user = await FirebaseAuth.instance.currentUser;
        //       final  authResult = await user?.reauthenticateWithCredential(
        //         EmailAuthProvider.credential(
        //           email: currentUser!.email!,
        //           password: "123123",
        //         ),
        //       );

        // // Then use the newly re-authenticated user
        //     await authResult?.user?.updateEmail(userModel.email);
              // final credential = await _firebaseAuth.signInWithEmailAndPassword(
              //   email: _firebaseAuth.currentUser!.email!,
              //   password: '123123',
              // );


              await currentUser?.updateDisplayName(name);
              await currentUser?.updateEmail(email);

              print("====================");
              print("====================");
              print("atualizou o EMAIL");
              print(email);
              print("====================");
              print("====================");
              print("====================");
              

              
              // await user?.updatePhotoURL("https://example.com/jane-q-user/profile.jpg");

              // //ALTERAR EMAIL NO FIREBASE
              // //ALTERAR NOME NO FIREBASE

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

  // Future<String?> signOut() async {
  //   try {
  //     await _firebaseAuth.signOut();
      
  //   } on FirebaseAuthException catch (e) {
  //     return e.code;
  //   }
  //   return null;
  // }

  // Future<String?> removerConta({required String senha}) async {
  //   try {
  //     await _firebaseAuth.signInWithEmailAndPassword(
  //       email: _firebaseAuth.currentUser!.email!,
  //       password: senha,
  //     );
  //     await _firebaseAuth.currentUser!.delete();
      
  //   } on FirebaseAuthException catch (e) {
  //     return e.code;
  //   }
  //   return null;
  // }
}