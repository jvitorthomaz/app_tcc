
import 'package:flutter/material.dart';

enum UpdateSchedulesStateStatus {
  initial,
  success,
  error;
}

class UpdateSchedulesState {
  final UpdateSchedulesStateStatus status;
  final int? scheduleTime;
  final DateTime? scheduleDate;

  UpdateSchedulesState.initial() : this(status: UpdateSchedulesStateStatus.initial);

    UpdateSchedulesState({
    required this.status,
    this.scheduleTime,
    this.scheduleDate
  });

  
  UpdateSchedulesState copyWith({
    UpdateSchedulesStateStatus? status,
    ValueGetter<int?>? scheduleHour,
    ValueGetter<DateTime?>? scheduleDate    
  }) {
    return UpdateSchedulesState(
      status: status ?? this.status,
      scheduleTime: scheduleHour != null ? scheduleHour() : scheduleTime,
      scheduleDate: scheduleDate != null ? scheduleDate() : this.scheduleDate
    );
  }
}
