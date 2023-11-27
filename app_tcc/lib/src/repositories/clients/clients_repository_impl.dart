import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/core/restClient/rest_client.dart';

class ClientsRepositoryImpl {

  final RestClient restClient;

  ClientsRepositoryImpl(
    {required RestClient restClient}
  ): restClient = restClient;

  @override
  Future<Either<RepositoryException, Nil>> registerClient(
     ({
      String clientName,
      int employee_id,
      DateTime date,
      int time
    }) clientData
  ) async{
    try {
      await restClient.auth.post(
        '/clients',
        data: {
          'client_name': clientData.clientName,
          'employee_id': clientData.employee_id,
          'date': clientData.date.toIso8601String(),
          'time': clientData.time,
        },
      );
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar cliente', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao agendar horário'));
    }
  }
}