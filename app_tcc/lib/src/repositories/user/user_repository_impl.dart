import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_app/src/core/exceptions/auth_exception.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/core/restClient/rest_client.dart';
import 'package:tcc_app/src/models/users_model.dart';
import 'package:tcc_app/src/repositories/user/auth_repository_impl.dart';
import 'package:tcc_app/src/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRespository {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthRepositoryImpl authRepository = AuthRepositoryImpl();
  final RestClient restClient;

  UserRepositoryImpl({
    required this.restClient
  });

  @override
  Future<Either<AuthException, String>> login(String email, String password) async{
    try {

      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );

      final Response(:data) = await restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });
      
      return Success(data['access_token']);

    } on DioException catch (e, s) {

      if (e.response != null) {
        final Response(:statusCode) = e.response!;

        if (statusCode == HttpStatus.forbidden) {
          log('Login ou senha inválidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());

        }
      }

      log('Erro ao Realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login'));
      
    }
    on FirebaseAuthException catch (e) {

      switch (e.code) {
        case "user-not-found":
        return Failure(AuthError(message: 'O e-mail não está cadastrado.'));
          
        case "wrong-password":
        return Failure(AuthError(message: 'Senha incorreta.'));
      }
      return Failure(AuthError(message: e.code));

    }
  }


  @override
  Future<Either<RepositoryException, UserModel>> me() async{
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Success(UserModel.fromMap(data));

    } on DioException catch (e, s) {
      log('Erro ao buscar os dados do usuário', error: e, stackTrace: s);

      return Failure(
        RepositoryException(message: 'Erro ao buscar os dados do usuário')
      );
      
    } on ArgumentError catch (e, s){
      log('Json Inválido', error: e, stackTrace: s);

      return Failure(
        RepositoryException(message: e.message)
      );

    }
  }


  @override
  Future<Either<RepositoryException, Nil>> registerUserAdm(
    ({String email, String name, String password}) userData
  ) async{
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userData.email,
        password: userData.password,
      );
      
      await userCredential.user!.updateDisplayName(userData.name);

      await restClient.unAuth.post(
        '/users',
        data: {
          'name': userData.name,
          'email': userData.email,
          'password': userData.password,
          'profile': 'ADM'
        },
      );

      return Success(nil);

    } on DioException catch (e, s) {
      log('Erro ao registrar usuário do tipo administrador', error: e, stackTrace: s);
      return Failure(
        RepositoryException(
          message: 'Erro ao registrar usuário do tipo administrador'
        )
      );

    }
    on FirebaseAuthException catch (e) {
      
      switch (e.code) {
        case "email-already-in-use":
        return Failure(
          RepositoryException(
            message: 'O e-mail já está em uso.'
          )
        );
      }
      return Failure(
        RepositoryException(
          message: 'Erro ao registrar usuário do tipo administrador: ${e.code}'
        )
      );
    }
  }
  

  @override
  Future<Either<RepositoryException, List<UserModel>>> getEmployees(int placeId) async{
    try {
      final Response(:List data) = await restClient.auth.get('/users', queryParameters: {'place_id': placeId});

      final employees = data.map((e) => EmployeeUserModel.fromMap(e)).toList();

      return Success(employees);

    } on DioException catch (e, s) {
      log('Erro ao buscar colaboradores', error: e, stackTrace: s);

      return Failure(
        RepositoryException(message: 'Erro ao buscar colaboradores')
      );

    } on ArgumentError catch (e, s) {

      log(
        'Erro ao converter colaboradores (Invalid Json)',
        error: e, stackTrace: s
      );

      return Failure(
        RepositoryException(
          message: 'Erro ao converter colaboradores (Invalid Json)'
        )
      );
    }
  }
  
  @override
  Future<Either<RepositoryException, Nil>> registerAdmAsEmployee(
    ({List<String> workDays, List<int> workHours}) userModel
  ) async{
    try {
      final userModelResult = await me();

      final int userId;

      switch (userModelResult) {
        case Success(value: UserModel(:var id)):
          userId = id;
          
        case Failure(:var exception):
          return Failure(exception);
      }

      await restClient.auth.put('/users/$userId', data: {
        'work_days': userModel.workDays,
        'work_hours': userModel.workHours,
      });

      return Success(nil);

    } on DioException catch (e, s) {

      log(
        'Erro ao inserir administrador como colaborador',
        error: e, 
        stackTrace: s
      );

      return Failure(
        RepositoryException(
          message: 'Erro ao inserir administrador como colaborador'
        )
      );
    }
  }
  

  @override
  Future<Either<RepositoryException, Nil>> registerNewEmployee(
    ({
      String email, 
      String name, 
      //String password, 
      int placeId, 
      List<String> workDays, 
      List<int> workHours
    }) userModel
  ) async{
    try {

      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: 'MyClinic#123!', //userModel.password,
      );

      await restClient.auth.post('/users/', data: {
        'name': userModel.name,
        'email': userModel.email,
        'password': 'MyClinic#123!', //userModel.password, //MyClinic#123!
        'place_id': userModel.placeId,
        'profile': 'EMPLOYEE',
        'work_days': userModel.workDays,
        'work_hours': userModel.workHours,
      });

      return Success(nil);

    } on DioException catch (e, s) {

      log(
        'Erro ao inserir administrador como colaborador',
        error: e, 
        stackTrace: s
      );

      return Failure(
        RepositoryException(
          message: 'Erro ao inserir administrador como colaborador'
        )
      );
    }
    on FirebaseAuthException catch (e) {
      
      switch (e.code) {
        case "email-already-in-use":
        return Failure(
          RepositoryException(
            message: 'O e-mail já está em uso.'
          )
        );
      }
      return Failure(
        RepositoryException(
          message: 'Erro ao registrar usuário do tipo colaborador: ${e.code}'
        )
      );
    }
  
  }


  @override
  Future<Either<RepositoryException, Nil>> updateEmployee(
    ({int employeeId, List<String> workDays, List<int> workHours}) userModel
  ) async{
    try {
      // final userModelResult = await me();

      final int employeeId = userModel.employeeId;

      // switch (userModelResult) {
      //   case Success(value: UserModel(:var id)):
      //     userId = id;
          
      //   case Failure(:var exception):
      //     return Failure(exception);
      // }
      

      await restClient.auth.put('/users/$employeeId', data: {
        //'name': userModel.name,
        'work_days': userModel.workDays,
        'work_hours': userModel.workHours,
      });

      return Success(nil);

    } on DioException catch (e, s) {

      log(
        'Erro ao editar colaborador',
        error: e, 
        stackTrace: s
      );

      return Failure(
        RepositoryException(
          message: 'Erro ao editar colaborador'
        )
      );
    }
  }


  @override
  Future<Either<RepositoryException, Nil>> updateLoggedUserPassword(
    ({int userId, String oldPassword, String newPassword}) userModel
  ) async{
    print('old: ${userModel.oldPassword}\nnew: ${userModel.newPassword}');
    try {

      final int userId = userModel.userId;

      final currentUser = FirebaseAuth.instance.currentUser;
      await currentUser?.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: currentUser.email!,
              password: userModel.oldPassword,
          ),
      );

      final user = _firebaseAuth.currentUser;
      // await user?.updateEmail(email);
      await user?.updatePassword(userModel.newPassword);

      await restClient.auth.put('/users/$userId', data: {
        //'name': userModel.name,
        'password': userModel.newPassword
      });

      return Success(nil);

    } 
      on FirebaseAuthException catch (e, s) {
      
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
    on DioException catch (e, s) {

      log(
        'Erro ao alterar senha de colaborador',
        error: e, 
        stackTrace: s
      );

      return Failure(
        RepositoryException(
          message: 'Erro ao alterar senha de colaborador'
        )
      );
    }
  }
  
  @override
  Future<Either<RepositoryException, Nil>> deleteUser(int idUser) async{
    try {
      // await _firebaseAuth.signInWithEmailAndPassword(
      //   email: _firebaseAuth.currentUser!.email!,
      //   password: senha,
      // );
      // await _firebaseAuth.currentUser!.delete();

      final response = await restClient.auth.delete(
        '/users/$idUser', 
        //queryParameters: {'id': ${scheduleData.idSchedule}}
      );

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro Deletar Usuario', error: e, stackTrace: s);

      return Failure(
        RepositoryException(message: 'Erro Deletar Usuario')
      );
    } 
    // on FirebaseAuthException catch (e) {
    //   return e.code;
    // }
  }


  //   Future<String?> redefinicaoSenha({required String email}) async {
  //   try {
  //     await _firebaseAuth.sendPasswordResetEmail(email: email);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == "user-not-found") {
  //       return "E-mail não cadastrado.";
  //     }
  //     return e.code;
  //   }
  //   return null;
  // }


  @override
  Future<String?> signOut() async {
    try {
      print('--------------\n Chega aqui \n ------------');
      await _firebaseAuth.signOut();
      
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return '';
  }
  
  @override
  Future<Either<RepositoryException, Nil>> updateUserProfile(
    ({int userId, String name, String email, List<String> workDays, List<int> workHours}) userModel
  ) async{
    try {
      // final userModelResult = await me();

      print("====================");
      print("====================");
      print("E-mail entrando no repository");
      print(userModel.email);
      print("====================");
      print("====================");
      print("====================");

      final name = userModel.name;
      final email = userModel.email;
      const password = '123123';

      await authRepository.updateUserProfileFirebase(email, name, password);

      final int userId = userModel.userId;

      if (userModel.workDays.isEmpty && userModel.workHours.isEmpty) {

        await restClient.auth.put('/users/$userId', data: {
          'name': userModel.name,
          'email': userModel.email,
        });
        
      } else if(userModel.workDays.isEmpty){

        await restClient.auth.put('/users/$userId', data: {
          'name': userModel.name,
          'email': userModel.email,
          'work_hours': userModel.workHours,
        });
        
      } else if(userModel.workHours.isEmpty){
        
        await restClient.auth.put('/users/$userId', data: {
          'name': userModel.name,
          'email': userModel.email,
          'work_days': userModel.workDays,
        });


      } else {
        await restClient.auth.put('/users/$userId', data: {
          'name': userModel.name,
          'email': userModel.email,
          'work_days': userModel.workDays,
          'work_hours': userModel.workHours,
        });

      }


      return Success(nil);

    } 
    on FirebaseAuthException catch (e, s) {
      
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
    on DioException catch (e, s) {

      log(
        'Erro ao editar colaborador',
        error: e, 
        stackTrace: s
      );

      return Failure(
        RepositoryException(
          message: 'Erro ao editar colaborador'
        )
      );
    }
  }

}
