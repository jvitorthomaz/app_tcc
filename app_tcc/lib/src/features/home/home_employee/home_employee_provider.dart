
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';

part 'home_employee_provider.g.dart';

@riverpod
Future<int> getTotalSchedulesToday(
  GetTotalSchedulesTodayRef ref,
  int userId,
) async {

  final DateTime(:year, :month, :day) = DateTime.now();
  final filter = (date: DateTime(year, month, day, 0, 0, 0), userId: userId);

  final scheduleResult = await ref.read(schedulesRepositoryProvider).findScheduleByDate(filter);

  return switch (scheduleResult) {
    Success(value: List(length: final totalSchedules)) => totalSchedules,

    Failure(:final exception) => throw exception,
  };
}

@riverpod
Future<int> getTotalSchedulesTomorrow(
  GetTotalSchedulesTomorrowRef ref,
  int userId,
) async {

  final DateTime(:year, :month, :day) = DateTime.now();
  final filter = (date: DateTime(year, month, day + 1, 0, 0), userId: userId);

  final scheduleResult = await ref.read(schedulesRepositoryProvider).findScheduleByDate(filter);

  return switch (scheduleResult) {
    Success(value: List(length: final totalSchedules)) => totalSchedules,

    Failure(:final exception) => throw exception,
  };
}
