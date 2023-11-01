import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app/src/core/constants/local_storage_keys.dart';
import 'package:tcc_app/src/core/exceptions/auth_exception.dart';
import 'package:tcc_app/src/core/exceptions/service_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/repositories/user/user_repository.dart';
import 'package:tcc_app/src/services/user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {

  final UserRespository userRespository;

  UserLoginServiceImpl({required this.userRespository});

  @override
  Future<Either<ServiceException, Nil>> execute(String email, String password) async {
    
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
}
