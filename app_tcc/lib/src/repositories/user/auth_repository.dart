

import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';

abstract interface class AuthRepository {

    Future<Either<RepositoryException, Nil>> updateUserProfileFirebase(
    ({
      String name,
      String password,
      String email,
    }) userModel
  );

}