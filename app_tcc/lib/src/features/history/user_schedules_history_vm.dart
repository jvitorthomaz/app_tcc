

import 'package:asyncstate/asyncstate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/models/schedules_model.dart';
import 'package:tcc_app/src/models/users_model.dart';

part 'user_schedules_history_vm.g.dart';

@riverpod
class UserSchedulesHistoryVm extends _$UserSchedulesHistoryVm{
  @override
  Future<List<SchedulesModel>> build(int userId) async =>
    switch (await _getSchedules(userId)) {
      Success(value: final schedules) => schedules,
      Failure(:final exception) => throw Exception(exception),
    };

  Future<Either<RepositoryException, List<SchedulesModel>>> _getSchedules(
    int userId,
  ) => ref.read(schedulesRepositoryProvider).getAllSchedules(userId);

    Future<void> deleteScheduleVm(int idSchedule) async {
      final asyncLoaderHandler = AsyncLoaderHandler()..start();

      final scheduleRepository = ref.read(schedulesRepositoryProvider);
      final deleteScheduleResult = await scheduleRepository.deleteSchedule(idSchedule);

      asyncLoaderHandler.close();
    }
}
