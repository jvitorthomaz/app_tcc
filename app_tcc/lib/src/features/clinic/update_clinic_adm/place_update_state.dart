// ignore_for_file: public_member_api_docs, sort_constructors_first

enum PlaceUpdateStateStatus{
  initial,
  success,
  error
}


class PlaceUpdateState {
  final PlaceUpdateStateStatus status;
  final List<String> openingDays;
  final List<int> openingHours;

  PlaceUpdateState.initial()
  : this(
    status: PlaceUpdateStateStatus.initial,
    openingDays: <String>[],
    openingHours: <int>[],
  );

    PlaceUpdateState({
    required this.status,
    required this.openingDays,
    required this.openingHours
  });

  PlaceUpdateState copyWith({
    PlaceUpdateStateStatus? status,
    List<String>? openingDays,
    List<int>? openingHours,
  }) {
    return PlaceUpdateState(
      status: status ?? this.status,
      openingDays: openingDays ?? this.openingDays,
      openingHours: openingHours ?? this.openingHours,
    );
  }
}
