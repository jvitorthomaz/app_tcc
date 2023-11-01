import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tcc_app/src/core/exceptions/auth_exception.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/restClient/rest_client.dart';
import 'package:tcc_app/src/models/users_model.dart';
import 'package:tcc_app/src/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRespository {

  final RestClient restClient;

  UserRepositoryImpl({
    required this.restClient
  });

  @override
  Future<Either<AuthException, String>> login(String email, String password) async{
    try {
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
      log('Json Inválido');

      return Failure(
        RepositoryException(message: e.message)
      );

    }
  }
  


}