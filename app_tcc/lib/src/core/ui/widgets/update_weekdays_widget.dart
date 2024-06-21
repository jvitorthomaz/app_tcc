import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/widgets/update_button_day_widget.dart';
//import 'package:tcc_app/src/core/ui/widgets/button_day_widget.dart';

class UpdateWeekdaysWidget extends StatelessWidget {

  final List<String>? enabledDays;
    final List<String>? preSelectedDays;
  final List<String>? selectedDays;
  final ValueChanged<String> onDayPressed;
  

  const UpdateWeekdaysWidget({
    super.key,
    this.enabledDays,
    required this.onDayPressed, 
    this.selectedDays, this.preSelectedDays,
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
                UpdateButtonDay(
                  label: 'Seg',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                  preSelectedDays: preSelectedDays,
                ),
                UpdateButtonDay(
                  label: 'Ter',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                  preSelectedDays: preSelectedDays,
                ),
                UpdateButtonDay(
                  label: 'Qua',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                  preSelectedDays: preSelectedDays,
                ),
                UpdateButtonDay(
                  label: 'Qui',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                  preSelectedDays: preSelectedDays,
                ),
                UpdateButtonDay(
                  label: 'Sex',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                  preSelectedDays: preSelectedDays,
                ),
                UpdateButtonDay(
                  label: 'Sab',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                  preSelectedDays: preSelectedDays,
                ),
                UpdateButtonDay(
                  label: 'Dom',
                  onDaySelected: onDayPressed,
                  enabledDays: enabledDays,
                  button: onDayPressed,
                  preSelectedDays: preSelectedDays,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
