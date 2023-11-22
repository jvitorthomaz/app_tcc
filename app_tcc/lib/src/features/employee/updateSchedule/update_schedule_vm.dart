

import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/features/employee/updateSchedule/update_schedule_state.dart';
import 'package:tcc_app/src/features/schedules/schedules_state.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:tcc_app/src/models/users_model.dart';

part 'update_schedule_vm.g.dart';

@riverpod
class UpdateSchedulesVm extends _$UpdateSchedulesVm{
  
  @override
  UpdateSchedulesState build() => UpdateSchedulesState.initial();

  void hourSelect(int hour) {
    if (hour == state.scheduleTime) {
      state = state.copyWith(scheduleHour: () => null);

    } else {
      state = state.copyWith(scheduleHour: () => hour);
    }
  }

  void deteSelected(DateTime date) {
    state = state.copyWith(scheduleDate: () => date);
  }

  Future<void> update(
    {required UserModel userModel, required String clientName, required int scheduleId}
  ) async {
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final UpdateSchedulesState(:scheduleDate, :scheduleTime) = state;

    final scheduleRepository = ref.read(schedulesRepositoryProvider);
    final PlaceModel(id: placeId) = await ref.watch(getAdmPlaceProvider.future);

    final dto = (
      //placeId: placeId,
      //userId: userModel.id,
      clientName: clientName,
      date: scheduleDate!,
      scheduleId: scheduleId,
      time: scheduleTime!,
    );

    final updateScheduleResult = await scheduleRepository.updateSchedule(dto);
    //final scheduleResult = await scheduleRepository.sheduleClient(dto);

    switch (updateScheduleResult) {
      case Success():
        state = state.copyWith(status: UpdateSchedulesStateStatus.success);

      case Failure():
        state = state.copyWith(status: UpdateSchedulesStateStatus.error);
        
    }

    asyncLoaderHandler.close();
  }
  
}