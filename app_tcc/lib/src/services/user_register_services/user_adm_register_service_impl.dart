import 'package:tcc_app/src/core/exceptions/service_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/repositories/user/user_repository.dart';
import 'package:tcc_app/src/services/user_login_services/user_login_service.dart';
import 'package:tcc_app/src/services/user_register_services/user_adm_register_service.dart';

class UserAdmRegisterServiceImpl implements UserAdmRegisterService{

  final UserRespository userRepository;
  final UserLoginService userLoginService;

  UserAdmRegisterServiceImpl({
    required this.userRepository, required this.userLoginService
  });
  
  @override
  Future<Either<ServiceException, Nil>> execute(({String email, String name, String password}) userData) async{
    final registerResult = await userRepository.registerUserAdm(userData);

    switch(registerResult) {

      case Success():
        return userLoginService.execute(userData.email, userData.password);

      case Failure(:final exception):
        return Failure(
          ServiceException(
            message: exception.message
          )
        );
    }

  }

}