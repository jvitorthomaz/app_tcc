import 'package:tcc_app/src/core/exceptions/auth_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';

abstract interface class UserRespository {
  Future<Either<AuthException, String>> login(String email, String password);
}