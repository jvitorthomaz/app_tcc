import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app/src/core/constants/local_storage_keys.dart';
import 'package:tcc_app/src/core/exceptions/auth_exception.dart';
import 'package:tcc_app/src/core/exceptions/service_exception.dart';
import 'package:tcc_app/src/core/exceptions/user_exists_exception.dart';
import 'package:tcc_app/src/core/exceptions/user_not_exists_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/repositories/user/user_repository.dart';
import 'package:tcc_app/src/services/user_login_services/user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {

  final UserRespository userRespository;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserLoginServiceImpl({required this.userRespository});

  @override
  Future<Either<ServiceException, Nil>> execute(String email, String password) async {

      // final firebaseAuth = FirebaseAuth.instance;

      // final userMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);

      // print('=====================');
      // print(userMethods);
      // print('=====================');
      // if (userMethods.isNotEmpty) {
      //   throw UserNotExistsException();
      // }
    
    final loginResult = await userRespository.login(email, password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final preferences = await SharedPreferences.getInstance();
        preferences.setString(LocalStorageKeys.accessToken, accessToken);
        return Success(nil);
      case Failure(:final exception):
        return switch (exception) {
          AuthError() =>
            Failure(ServiceException(message: 'Erro ao realizar login')),
          AuthUnauthorizedException() =>
            Failure(ServiceException(message: 'Login ou Senha Inválidos')),
        };
    }

  }


  // @override
  // Future<Either<ServiceException, Nil>> executeLoginFirebase(
  //   ({
  //     int userId,
  //     String name,
  //     String email,
  //     List<String> workDays,
  //     List<int> workHours,
  //   }) userModel
  // ) async {


  //     await _firebaseAuth.signInWithEmailAndPassword(
  //       email: _firebaseAuth.currentUser!.email!,
  //       password: '123123',
  //     );
    
  //   final loginResult = await userRespository.updateUserProfile(
  //     userModel
  //   );

  //   switch(loginResult) {

  //     case Success():
  //       return Success(nil);

  //     case Failure(:final exception):
  //       return Failure(
  //         ServiceException(
  //           message: exception.message
  //         )
  //       );
  //   }



  // }
}
