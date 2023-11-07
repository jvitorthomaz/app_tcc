import 'package:flutter/material.dart';

enum SchedulesStateStatus {
  initial,
  success,
  error;
}


class SchedulesState {
  final SchedulesStateStatus status;
  final int? scheduleTime;
  final DateTime? scheduleDate;

  SchedulesState.initial() : this(status: SchedulesStateStatus.initial);

    SchedulesState({
    required this.status,
    this.scheduleTime,
    this.scheduleDate
  });

  
  SchedulesState copyWith({
    SchedulesStateStatus? status,
    ValueGetter<int?>? scheduleHour,
    ValueGetter<DateTime?>? scheduleDate    
  }) {
    return SchedulesState(
      status: status ?? this.status,
      scheduleTime: scheduleHour != null ? scheduleHour() : scheduleTime,
      scheduleDate: scheduleDate != null ? scheduleDate() : this.scheduleDate
    );
  }
}
