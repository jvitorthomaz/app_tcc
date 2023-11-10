
import 'package:asyncstate/asyncstate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/models/schedules_model.dart';

part 'employee_schedules_vm.g.dart';

@riverpod
class EmployeeSchedulesVm extends _$EmployeeSchedulesVm{

  // @override
  // Future<List<SchedulesModel>> build(int userId, DateTime date) async {
  //   final scheduleListResult = await _getSchedules(userId, date);

  //   return switch (scheduleListResult) {
  //     Success(value: final schedules) => schedules,
  //     Failure(:final exception) => throw Exception(exception),
  //   };

  // }
  
  @override
  Future<List<SchedulesModel>> build(int userId, DateTime date) async =>
    switch (await _getSchedules(userId, date)) {
      Success(value: final schedules) => schedules,
      Failure(:final exception) => throw Exception(exception),
    };

  Future<void> changeDate(int userId, DateTime date) async =>
    state = switch (await _getSchedules(userId, date)) {
      Success(value: final schedules) => AsyncData(schedules),

      Failure(:final exception) =>
        AsyncError(Exception(exception), StackTrace.current),
    };

  // Future<Either<RepositoryException, List<SchedulesModel>>> _getSchedules(
  //   int userId,
  //   DateTime date,
  // ) {
  //   final repository = ref.read(schedulesRepositoryProvider);
  //   return repository.findScheduleByDate((userId: userId, date: date));
  // }

  Future<Either<RepositoryException, List<SchedulesModel>>> _getSchedules(
    int userId,
    DateTime date,
  ) => ref.read(schedulesRepositoryProvider).findScheduleByDate((userId: userId, date: date));



    Future<void> deleteScheduleVm(int idSchedule) async {
      final asyncLoaderHandler = AsyncLoaderHandler()..start();

      // final scheduleRepository = ref.read(schedulesRepositoryProvider);
      // final PlaceModel(id: placeId) = await ref.watch(getAdmPlaceProvider.future);

      // final dto = (
      //   placeId: placeId,
      //   userId: userModel.id,
      //   clientName: clientName,
      //   date: scheduleDate!,
      //   time: scheduleTime!,
      // );
      final scheduleRepository = ref.read(schedulesRepositoryProvider);
      final deleteScheduleResult = await scheduleRepository.deleteSchedule(idSchedule);

      // switch (deleteScheduleResult) {
      //   case Success():
      //     state = state.copyWith(status: SchedulesStateStatus.success);

      //   case Failure():
      //     state = state.copyWith(status: SchedulesStateStatus.error);
          
      // }

      asyncLoaderHandler.close();
    }

}
