import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcc_app/src/core/functionalPrograming/either.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/features/auth/register/register_clinic/place_register_state.dart';

part 'place_register_vm.g.dart';

@riverpod
class PlaceRegisterVm extends _$PlaceRegisterVm {

  @override
  PlaceRegisterState build() => PlaceRegisterState.initial();

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


  Future<void> register({required String name, required String email}) async {

    final repository = ref.watch(placesRepositoryProvider);

    final PlaceRegisterState(:openingDays, :openingHours) = state;

    final registerPlaceDto = (
      name: name,
      email: email,
      openingDays: openingDays,
      openingHours: openingHours
    );

    final registerResult = await repository.savePlace(registerPlaceDto);

    switch(registerResult) {
      case Success():
        // invalidar para limpar o cache (Faz um refresh)
        ref.invalidate(getAdmPlaceProvider);
        state = state.copyWith(status: PlaceRegisterStateStatus.success);

      case Failure():
        state = state.copyWith(status: PlaceRegisterStateStatus.error);

    }
  }

}
