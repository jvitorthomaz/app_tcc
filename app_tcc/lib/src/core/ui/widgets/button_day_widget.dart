import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';

class ButtonDay extends StatefulWidget {
  final List<String>? enabledDays;
  final String label;
  final ValueChanged<String> onDaySelected;

  const ButtonDay({
    super.key,
    required this.label,
    required this.onDaySelected,
    this.enabledDays,
  });

  @override
  State<ButtonDay> createState() => _ButtonDayState();
}

class _ButtonDayState extends State<ButtonDay> {
  var selectedButton = false;

  @override
  Widget build(BuildContext context) {
    final textColor = selectedButton ? Colors.white : AppColors.colorGrey;
    var buttonColor = selectedButton ? AppColors.colorGreenLight : Colors.white;
    final buttonBorderColor = selectedButton ? AppColors.colorGreen : AppColors.colorGrey;

    final ButtonDay(:enabledDays, :label) = widget;

    final disableDay = enabledDays != null && !enabledDays.contains(label);
    if (disableDay) {
      buttonColor = Colors.grey[400]!;
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: disableDay
            ? null
            : () {
                widget.onDaySelected(label);
                setState(() {
                  selectedButton = !selectedButton;
                });
              },
        child: Container(
          width: 39.5,
          height: 55,
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
                fontSize: 12, color: textColor, fontWeight: FontWeight.w500),
          )),
        ),
      ),
    );
  }
}