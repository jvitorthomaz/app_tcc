
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';

class SchedulesCalendar extends StatefulWidget{
  final VoidCallback cancelPressed;
  final ValueChanged<DateTime> onOkPressed;
  final List<String> workDays;

  const SchedulesCalendar({
    Key? key,
    required this.cancelPressed,
    required this.onOkPressed,
    required this.workDays,
  }) : super(key: key);

  @override
  State<SchedulesCalendar> createState() => _SchedulesCalendarState();
  
}

class _SchedulesCalendarState extends State<SchedulesCalendar> {
  DateTime? selectedDay;
  late final List<int> weekDaysEnabled;

  int convertWeekDay(String weekDay) => switch (weekDay.toLowerCase()) {
    'seg' => DateTime.monday,
    'ter' => DateTime.tuesday,
    'qua' => DateTime.wednesday,
    'qui' => DateTime.thursday,
    'sex' => DateTime.friday,
    'sab' => DateTime.saturday,
    'dom' => DateTime.sunday,
    _ => 0,
  };

  @override
  void initState() {
    super.initState();
    weekDaysEnabled = widget.workDays.map(convertWeekDay).toList();
  }

    @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        //color: Colors.grey.shade200,
        color: const Color(0xffe6e2e9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          TableCalendar(
            availableGestures: AvailableGestures.none,
            headerStyle: const HeaderStyle(titleCentered: true),
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2015, 04, 20),
            lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
            calendarFormat: CalendarFormat.month,
            locale: 'pt_BR',
            availableCalendarFormats: const {CalendarFormat.month: 'Mês'},
            enabledDayPredicate: (day) {
              return weekDaysEnabled.contains(day.weekday);
            },
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: AppColors.colorGreen, shape: BoxShape.circle
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.colorGreenLight,//ColorConstants.colorBrown.withOpacity(0.4),
                shape: BoxShape.circle
              )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: widget.cancelPressed,
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.colorGreen,
                  ),
                ),
              ),
              const SizedBox(
                width: 10 ,
              ),
              TextButton(
                onPressed: () {
                  if (selectedDay == null) {
                    MessagesHelper.showErrorSnackBar('Por favor, selecione um dia para agendamento', context);
                    return;
                  }
                  widget.onOkPressed(selectedDay!);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorGreen,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
