import 'package:firebase_auth/firebase_auth.dart';

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