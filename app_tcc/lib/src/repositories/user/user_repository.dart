import 'package:tcc_app/src/core/exceptions/auth_exception.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/models/users_model.dart';

abstract interface class UserRespository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();

  Future<Either<RepositoryException, Nil>> registerUserAdm(({
    String name,
    String email,
    String password,
  }) userData);

  Future<Either<RepositoryException, List<UserModel>>> getEmployees(
    int placeId
  );


  Future<Either<RepositoryException, Nil>> registerAdmAsEmployee(
    ({
      List<String> workDays,
      List<int> workHours,
    }) userModel
  );

  Future<Either<RepositoryException, Nil>> registerNewEmployee(
    ({
      int placeId,
      String name,
      String email,
      //String password,
      List<String> workDays,
      List<int> workHours,
    }) userModel
  );    

    Future<Either<RepositoryException, Nil>> updateEmployee(
    ({
      //String name,
      int employeeId,
      List<String> workDays,
      List<int> workHours,
    }) userModel
  );

  Future<Either<RepositoryException, Nil>> deleteUser( int idUser );

  //Future<String?> redefinicaoSenha({required String email});

  Future<String?> signOut();



}
