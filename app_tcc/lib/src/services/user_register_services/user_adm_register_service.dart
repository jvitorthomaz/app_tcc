import 'package:tcc_app/src/core/exceptions/service_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';

abstract interface class UserAdmRegisterService {
  Future<Either<ServiceException, Nil>> execute(({
    String name, String email, String password
  }) userData);
  
}