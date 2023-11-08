
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/core/restClient/rest_client.dart';
import 'package:tcc_app/src/models/schedules_model.dart';
import 'package:tcc_app/src/repositories/schedules/schedules_repository.dart';

class SchedulesRepositoryImpl  implements SchedulesRepository{

  final RestClient restClient;

  SchedulesRepositoryImpl(
    {required RestClient restClient}
  ): restClient = restClient;

  @override
  Future<Either<RepositoryException, Nil>> sheduleClient(
    ({String clientName, DateTime date, int placeId, int time, int userId}) scheduleData
  ) async{
    try {
      await restClient.auth.post(
        '/schedules',
        data: {
          'place_id': scheduleData.placeId,
          'user_id': scheduleData.userId,
          'client_name': scheduleData.clientName,
          'date': scheduleData.date.toIso8601String(),
          'time': scheduleData.time,
        },
      );
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar agendamento', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao agendar horário'));
    }
  }

  @override
  Future<Either<RepositoryException, List<SchedulesModel>>> findScheduleByDate(
  ({
    DateTime date,
    int userId,
  }) filter) async {
    try {
      final Response(:List data) = await restClient.auth.get('/schedules', queryParameters: {
        'user_id': filter.userId,
        'date': filter.date.toIso8601String(),
      });

      final schedules = data.map((res) => SchedulesModel.fromMap(res)).toList();
      return Success(schedules);

    } on DioException catch (e, s) {
      log('Erro ao buscar agendamentos de uma data', error: e, stackTrace: s);
      return Failure(
        RepositoryException(
          message: 'Erro ao buscar agendamentos de uma data'
        )
      );

    } on ArgumentError catch (e, s) {
      log('Json Invalido', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Json Invalido'));
    }
  }
  
}
