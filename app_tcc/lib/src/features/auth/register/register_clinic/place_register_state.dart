// ignore_for_file: public_member_api_docs, sort_constructors_first

enum PlaceRegisterStateStatus{
  initial,
  success,
  error
}


class PlaceRegisterState {
  final PlaceRegisterStateStatus status;
  final List<String> openingDays;
  final List<int> openingHours;

  PlaceRegisterState.initial()
  : this(
    status: PlaceRegisterStateStatus.initial,
    openingDays: <String>[],
    openingHours: <int>[],
  );

    PlaceRegisterState({
    required this.status,
    required this.openingDays,
    required this.openingHours
  });


  
  

  PlaceRegisterState copyWith({
    PlaceRegisterStateStatus? status,
    List<String>? openingDays,
    List<int>? openingHours,
  }) {
    return PlaceRegisterState(
      status: status ?? this.status,
      openingDays: openingDays ?? this.openingDays,
      openingHours: openingHours ?? this.openingHours,
    );
  }
}
