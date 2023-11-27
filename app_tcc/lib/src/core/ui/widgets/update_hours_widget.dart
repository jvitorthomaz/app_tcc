import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/widgets/update_button_hour_widget.dart';
//import 'package:tcc_app/src/core/ui/widgets/button_hour_widget.dart';

class UpdateHoursWidget extends StatefulWidget {
  final List<int>? enabledTimes;
  final List<int>? preSelectedTimes;
  final List<int>? selectedTimes;
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;
  final bool singleSelection;

  const UpdateHoursWidget({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enabledTimes, 
    this.selectedTimes, this.preSelectedTimes,
  }) : singleSelection = false;

  const UpdateHoursWidget.singleSelection({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enabledTimes, 
    this.selectedTimes, this.preSelectedTimes,
  }) : singleSelection = true;

  @override
  State<UpdateHoursWidget> createState() => _UpdateHoursWidgetState();
}

class _UpdateHoursWidgetState extends State<UpdateHoursWidget> {
  int? lastSelection;

  @override
  Widget build(BuildContext context) {
    final UpdateHoursWidget(:singleSelection) = widget;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione os horários de atendimento',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 20,
          runSpacing: 16,
          children: [
            for (int i = widget.startTime; i <= widget.endTime; i++)
              UpdateHourButton(
                preSelectedTimes: widget.preSelectedTimes,
                label: '${i.toString().padLeft(2, '0')}:00',
                value: i,
                timeSelected: lastSelection,
                singleSelection: widget.singleSelection,
                onPressed: (timeSelected) {
                  setState(() {
                    if (singleSelection) {
                      if(lastSelection == timeSelected) {
                        lastSelection = null;

                      } else {
                        lastSelection = timeSelected;

                      }
                    }
                  });
                  widget.onHourPressed(timeSelected);
                },
                enabledTimes: widget.enabledTimes,
              )
          ],
        )
      ],
    );
  }
}
