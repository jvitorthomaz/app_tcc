import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/features/schedules/schedules_state.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:tcc_app/src/models/users_model.dart';

part 'schedules_vm.g.dart';

@riverpod
class SchedulesVm extends _$SchedulesVm{
  
  @override
  SchedulesState build() => SchedulesState.initial();

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

  Future<void> register(
    {required UserModel userModel, required String clientName}
  ) async {
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final SchedulesState(:scheduleDate, :scheduleTime) = state;

    final scheduleRepository = ref.read(schedulesRepositoryProvider);
    final PlaceModel(id: placeId) = await ref.watch(getAdmPlaceProvider.future);

    final dto = (
      placeId: placeId,
      userId: userModel.id,
      clientName: clientName,
      date: scheduleDate!,
      time: scheduleTime!,
    );

    final scheduleResult = await scheduleRepository.sheduleClient(dto);

    switch (scheduleResult) {
      case Success():
        state = state.copyWith(status: SchedulesStateStatus.success);

      case Failure():
        state = state.copyWith(status: SchedulesStateStatus.error);
        
    }

    asyncLoaderHandler.close();
  }
  
}
