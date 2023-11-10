import 'package:tcc_app/src/core/exceptions/repository_exception.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/functionalPrograming/nil.dart';
import 'package:tcc_app/src/models/schedules_model.dart';

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

  Future<Either<RepositoryException, List<SchedulesModel>>> findScheduleByDate(
    ({
      //int idSchedule,
      DateTime date,
      int userId,
      
    }) filter 
  );

  Future<Either<RepositoryException, Nil>> deleteSchedule( int idSchedule );
}
