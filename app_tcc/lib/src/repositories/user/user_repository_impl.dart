import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app/src/core/exceptions/auth_exception.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/core/restClient/rest_client.dart';
import 'package:tcc_app/src/models/image_custom_info_model.dart';
import 'package:tcc_app/src/models/users_model.dart';
import 'package:tcc_app/src/repositories/user/auth_repository_impl.dart';
import 'package:tcc_app/src/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRespository {
  final RestClient restClient;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthRepositoryImpl authRepository = AuthRepositoryImpl();

  UserRepositoryImpl({
    required this.restClient
  });
    // String pathService = FirebaseAuth.instance.currentUser!.uid;
    // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<Either<AuthException, String>> login(String email, String password) async{
    try {

      final preferences = await SharedPreferences.getInstance();
      await preferences.setString('loggedUserEmail', email);
      await preferences.setString('loggedUserPassword', password);

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
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString('loggedUserEmail', userData.email);
      await preferences.setString('loggedUserPassword', userData.password);
      
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

      final preferences = await SharedPreferences.getInstance();
      final myEmail = preferences.getString('loggedUserEmail')!;
      final myPW = preferences.getString('loggedUserPassword')!;
      print('=========================');
      print('=========================');
      print('Reautenticação');
      print(myEmail);
      print(myPW);
      print('=========================');
      print('=========================');

      await _firebaseAuth.signOut();


      await _firebaseAuth.signInWithEmailAndPassword(
        email: myEmail, 
        password: myPW
      );


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
      // final name = userModel.name;
      // final email = userModel.email;
      // const password = '123123';

      // await authRepository.updateUserProfileFirebase(email, name, password);

      final int userId = userModel.userId;
      await restClient.auth.put('/users/$userId', data: {
        'name': userModel.name,
        'email': userModel.email,
        'work_days': userModel.workDays,
        'work_hours': userModel.workHours,
      });


      // if (userModel.workDays.isEmpty && userModel.workHours.isEmpty) {

      //   await restClient.auth.put('/users/$userId', data: {
      //     'name': userModel.name,
      //     'email': userModel.email,
      //   });
        
      // } else if(userModel.workDays.isEmpty){

      //   await restClient.auth.put('/users/$userId', data: {
      //     'name': userModel.name,
      //     'email': userModel.email,
      //     'work_hours': userModel.workHours,
      //   });
        
      // } else if(userModel.workHours.isEmpty){
        
      //   await restClient.auth.put('/users/$userId', data: {
      //     'name': userModel.name,
      //     'email': userModel.email,
      //     'work_days': userModel.workDays,
      //   });


      // } else {
      //   await restClient.auth.put('/users/$userId', data: {
      //     'name': userModel.name,
      //     'email': userModel.email,
      //     'work_days': userModel.workDays,
      //     'work_hours': userModel.workHours,
      //   });

      // }


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


  //   @override
  // Future<Either<RepositoryException, Nil>> uploadUserProfilePicture(
  //   ({int userId, String firebaseUUID, String fileName}) userModel
  // ) async{
  //   try {

  //     final int userId = userModel.userId;
  //     final String firebaseUUID = userModel.firebaseUUID;
  //     final String fileName = userModel.fileName;

  //     await restClient.auth.put('/users/$userId', data: {
  //       //'name': userModel.name,
  //       'firebase_UUID': firebaseUUID,
  //       'profile_file_name': fileName,
  //     });

  //     return Success(nil);

  //   } 
  //   on DioException catch (e, s) {

  //     log(
  //       'Erro ao editar colaborador',
  //       error: e, 
  //       stackTrace: s
  //     );

  //     return Failure(
  //       RepositoryException(
  //         message: 'Erro ao editar colaborador'
  //       )
  //     );
  //   }
  // }



  @override
  Future<String> uploadUserProfilePicture(
    {required File file, required String fileName, required int userId,}
  ) async {
    //String pathService = FirebaseAuth.instance.currentUser!.uid;
    final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    final firebaseUUID = _firebaseAuth.currentUser!.uid;
    await _firebaseStorage.ref("$firebaseUUID/$fileName.png").putFile(file);

    String url = await _firebaseStorage
        .ref("$firebaseUUID/$fileName.png")
        .getDownloadURL();

    await _firebaseAuth.currentUser!.updatePhotoURL(url);

    await restClient.auth.put('/users/$userId', data: {
        //'name': userModel.name,
        'firebase_UUID': firebaseUUID,
        'profile_file_name': fileName,
    });




    return url;
  }

  // Future<String> getDownloadUrlByFileName({required String fileName}) async {
  //   String pathService = await FirebaseAuth.instance.currentUser!.uid;
  //   final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  //   return await _firebaseStorage
  //       .ref("$pathService/$fileName.png")
  //       .getDownloadURL();
  // }

  // Future<List<ImageCustomInfoModel>> listAllFiles() async {
  //   //String pathService = await FirebaseAuth.instance.currentUser!.uid;
  //   final firebaseUUID = _firebaseAuth.currentUser!.uid;
  //   final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  //   ListResult result = await _firebaseStorage.ref(pathService).listAll();
  //   List<Reference> listReferences = result.items;

  //   List<ImageCustomInfoModel> listFiles = [];

  //   for (Reference reference in listReferences) {
  //     String urlDownload = await reference.getDownloadURL();
  //     String name = reference.name;

  //     FullMetadata metadados = await reference.getMetadata();
  //     int? size = metadados.size;

  //     String sizeString = "Sem informação de tamanho.";

  //     if (size != null) {
  //       sizeString = "${size / 1000} Kb";
  //     }

  //     listFiles.add(
  //       ImageCustomInfoModel(
  //         urlDownload: urlDownload,
  //         name: name,
  //         size: sizeString,
  //         ref: reference
  //       )
  //     );
  //   }

  //   return listFiles;
  // }

  // Future<void> deleteByReference({required ImageCustomInfoModel imageInfo}) async {
  //   if (_firebaseAuth.currentUser!.photoURL != null) {
  //     if (_firebaseAuth.currentUser!.photoURL! == imageInfo.urlDownload) {
  //       await _firebaseAuth.currentUser!.updatePhotoURL(null);
  //     }
  //   }
  //   return await imageInfo.ref.delete();
  // }
}
