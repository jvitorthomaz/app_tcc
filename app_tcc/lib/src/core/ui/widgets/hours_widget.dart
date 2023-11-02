import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/widgets/button_hour_widget.dart';

class HoursPanel extends StatefulWidget {
  final List<int>? enabledTimes;
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;
  final bool singleSelection;

  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enabledTimes,
  }) : singleSelection = false;

  const HoursPanel.singleSelection({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enabledTimes,
  }) : singleSelection = true;

  @override
  State<HoursPanel> createState() => _HoursPanelState();
}

class _HoursPanelState extends State<HoursPanel> {
  int? lastSelection;

  @override
  Widget build(BuildContext context) {
    final HoursPanel(:singleSelection) = widget;
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
              HourButton(
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
