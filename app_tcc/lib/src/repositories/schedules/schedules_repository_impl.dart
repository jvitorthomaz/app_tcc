
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/core/restClient/rest_client.dart';
import 'package:tcc_app/src/models/schedules_model.dart';
import 'package:tcc_app/src/repositories/clients/clients_repository_impl.dart';
import 'package:tcc_app/src/repositories/schedules/schedules_repository.dart';

class SchedulesRepositoryImpl implements SchedulesRepository{

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
          'schedule_note': '',
          'date': scheduleData.date.toIso8601String(),
          'time': scheduleData.time,
        },
      );

      final registerClientDto = (
        clientName: scheduleData.clientName,
        employeeId: scheduleData.userId,
        date: scheduleData.date.toIso8601String(),
        time: scheduleData.time,
      );

      registerClient(registerClientDto);


      
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar agendamento', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao agendar horário'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerClient(
    ({
      String clientName,
      int employeeId,
      String date,
      int time
    })clientData

  ) async{
    try {
      await restClient.auth.post(
        '/clients',
        data: {
          'client_name': clientData.clientName,
          'employee_id': clientData.employeeId,
          'date': clientData.date,
          'time': clientData.time,
        },
      );
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar cliente', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao agendar horário'));
    }
  }

  @override
  Future<Either<RepositoryException, List<SchedulesModel>>> findScheduleByDate(
  ({
    DateTime date,
    int userId,
    //int idSchedule
  }) filter) async {
    try {
      final Response(:List data) = await restClient.auth.get('/schedules', queryParameters: {
        'user_id': filter.userId,
        'date': filter.date.toIso8601String(),
        //'id' : filter.idSchedule
      });

      final schedules = data.map((s) => SchedulesModel.fromMap(s)).toList();
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


  @override
  Future<Either<RepositoryException, Nil>> updateSchedule(
    ({int scheduleId, String clientName, DateTime date, int time,}) scheduleData
  ) async{
    try {
      // final userModelResult = await me();

      final int scheduleId = scheduleData.scheduleId;

      // switch (userModelResult) {
      //   case Success(value: UserModel(:var id)):
      //     userId = id;
          
      //   case Failure(:var exception):
      //     return Failure(exception);
      // }

      await restClient.auth.put('/schedules/$scheduleId', data: {
        //'name': userModel.name,
          'client_name': scheduleData.clientName,
          'date': scheduleData.date.toIso8601String(),
          'time': scheduleData.time,
      });

      return Success(nil);

    } on DioException catch (e, s) {

      log(
        'Erro ao editar agendamento',
        error: e, 
        stackTrace: s
      );

      return Failure(
        RepositoryException(
          message: 'Erro ao editar agendamento'
        )
      );
    }
  }

  
  @override
  Future<Either<RepositoryException, Nil>> deleteSchedule(int idSchedule) async {
    try {
      final response = await restClient.auth.delete(
        '/schedules/$idSchedule', 
        //queryParameters: {'id': ${scheduleData.idSchedule}}
      );

      return Success(nil);

    } on DioException catch (e, s) {
      log('Erro Deletar Agendamento', error: e, stackTrace: s);

      return Failure(
        RepositoryException(message: 'Erro Deletar Agendamento')
      );
    } 

  }


    @override
  Future<Either<RepositoryException, List<SchedulesModel>>> getAllSchedules(
    int userId,) async {
    try {
      final Response(:List data) = await restClient.auth.get(
        '/schedules', queryParameters: {
          'user_id': userId,
        }
      );

      final schedules = data.map((s) => SchedulesModel.fromMap(s)).toList();
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

  @override
  Future<Either<RepositoryException, Nil>> insertScheduleNote(
    ({int scheduleId, String note}) scheduleData
  ) async{
    try {
      // final userModelResult = await me();

      final int scheduleId = scheduleData.scheduleId;

      // switch (userModelResult) {
      //   case Success(value: UserModel(:var id)):
      //     userId = id;
          
      //   case Failure(:var exception):
      //     return Failure(exception);
      // }

      await restClient.auth.patch('/schedules/$scheduleId', data: {
        'schedule_note': scheduleData.note,
      });

      return Success(nil);

    } on DioException catch (e, s) {

      log(
        'Erro ao inserir nota sobre agendamento',
        error: e, 
        stackTrace: s
      );

      return Failure(
        RepositoryException(
          message: 'Erro ao editar agendamento'
        )
      );
    }
  }
  
}
