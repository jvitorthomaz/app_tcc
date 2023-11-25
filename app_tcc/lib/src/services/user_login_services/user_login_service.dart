import 'package:tcc_app/src/core/exceptions/service_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';

abstract interface class UserLoginService {
  Future<Either<ServiceException, Nil>> execute(String email, String password);

  //  Future<Either<ServiceException, Nil>> executeLoginFirebase(
  //   ({
  //     int userId,
  //     String name,
  //     String email,
  //     List<String> workDays,
  //     List<int> workHours,
  //   }) userModel
  // );
}
