import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';

abstract interface class SchedulesRepository {
  Future<Either<RepositoryException, Nil>> sheduleClient(
    ({
      int placeId,
      int userId,
      String clientName,
      DateTime date,
      int time
    }) scheduleData
  );

  // Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
  //   ({
  //     DateTime date,
  //     int userId,
  //   }) filter );
}
