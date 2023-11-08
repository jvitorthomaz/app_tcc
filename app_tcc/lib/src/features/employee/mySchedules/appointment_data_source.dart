
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/models/schedules_model.dart';

class AppointmentDataSource extends CalendarDataSource{
  AppointmentDataSource({
    required this.schedules,
  });

  final List<SchedulesModel> schedules;

  @override
  List<dynamic>? get appointments => schedules.map((e) {
    final SchedulesModel(
      date: DateTime(:year, :month, :day),
      :hour,
      :clientName,
    ) = e;

    final startTime = DateTime(year, month, day, hour, 0, 0);
    final endTime = DateTime(year, month, day, hour + 1, 0, 0);

    return Appointment(
      color: AppColors.colorGreen,
      startTime: startTime,
      endTime: endTime,
      subject: clientName,
    );
  }).toList();

  
  
}