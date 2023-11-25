import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/features/clinic/update_clinic_adm/place_update_state.dart';

part 'place_update_vm.g.dart';

@riverpod
class PlaceUpdateVm extends _$PlaceUpdateVm {

  @override
  PlaceUpdateState build() => PlaceUpdateState.initial();

  void addOrRemoveOpenDay(String weekDay) {
    final openingDays = state.openingDays;

    if(openingDays.contains(weekDay)) {
      openingDays.remove(weekDay);

    } else {
      openingDays.add(weekDay);
      
    }

    state = state.copyWith(openingDays: openingDays);
  }


  void addOrRemoveOpenHour(int hour) {
    final openingHours = state.openingHours;
    if(openingHours.contains(hour)) {
      openingHours.remove(hour);
    } else {
      openingHours.add(hour);
    }

    state = state.copyWith(openingHours: openingHours);
  }


  Future<void> update({required int placeId, required String name, required String email}) async {

    final repository = ref.watch(placesRepositoryProvider);

    final PlaceUpdateState(:openingDays, :openingHours) = state;

    final updatePlaceDto = (
      placeId: placeId,
      name: name,
      email: email,
      openingDays: openingDays,
      openingHours: openingHours
    );

    final updateResult = await repository.updatePlace(updatePlaceDto);

    switch(updateResult) {
      case Success():
        // invalidar para limpar o cache (Faz um refresh)
        ref.invalidate(getAdmPlaceProvider);
        state = state.copyWith(status: PlaceUpdateStateStatus.success);

      case Failure():
        state = state.copyWith(status: PlaceUpdateStateStatus.error);

    }
  }

}
