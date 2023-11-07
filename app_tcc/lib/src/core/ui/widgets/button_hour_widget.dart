import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';

class HourButton extends StatefulWidget {
  final List<int>? enabledTimes;
  final String label;
  final int value;
  final ValueChanged<int> onPressed;
  final bool singleSelection;
  final int? timeSelected;

  const HourButton({
    super.key,
    this.enabledTimes,
    required this.label,
    required this.value,
    required this.onPressed,
    required this.singleSelection,
    required this.timeSelected,
  });

  @override
  State<HourButton> createState() => _HourButtonState();
}

class _HourButtonState extends State<HourButton> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    final HourButton(
      :value,
      :label,
      :onPressed,
      :enabledTimes,
      :singleSelection,
      :timeSelected
    ) = widget;
    
    if (singleSelection) {
      if(timeSelected != null && timeSelected == value) {
        selected = true;
      } else {
        selected = false;
      }
    }

    final textColor = selected ? Colors.white : AppColors.colorGrey;
    var buttonColor = selected ? AppColors.colorGreenLight : Colors.white;
    final buttonBorderColor = selected ? AppColors.colorGreen : AppColors.colorGrey;

    final bool disableTime = enabledTimes != null && !enabledTimes.contains(value);

    if (disableTime) {
      buttonColor = Colors.grey[350]!;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disableTime
          ? null
          : () {
              setState(() {
                selected = !selected;
                onPressed(value);
              });
            },
      child: Container(
        width: 65,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor,
          border: Border.all(
            color: buttonBorderColor,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}