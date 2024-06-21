import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/widgets/button_day_widget.dart';

class WeekdaysWidget extends StatelessWidget {

  final List<String>? enabledDays;
  final ValueChanged<String> onDayPressed;


  const WeekdaysWidget({
    super.key,
    this.enabledDays,
    required this.onDayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecione os dias da semana',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonDay(
                  label: 'Seg',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                ),
                ButtonDay(
                  label: 'Ter',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                ),
                ButtonDay(
                  label: 'Qua',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                ),
                ButtonDay(
                  label: 'Qui',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                ),
                ButtonDay(
                  label: 'Sex',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                ),
                ButtonDay(
                  label: 'Sab',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                ),
                ButtonDay(
                  label: 'Dom',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
