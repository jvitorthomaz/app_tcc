import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';

class UpdateButtonDay extends StatefulWidget {
  final List<String>? enabledDays;
  final List<String>? preSelectedDays;
  final String label;
  final ValueChanged<String> onDaySelected;
  final button;//

  const UpdateButtonDay({
    super.key,
    required this.label,
    required this.onDaySelected,
    this.enabledDays,
    this.button, this.preSelectedDays //
  });

  @override
  State<UpdateButtonDay> createState() => _UpdateButtonDayState();
}

class _UpdateButtonDayState extends State<UpdateButtonDay> {
  var selectedButton = false;
  

  @override
  Widget build(BuildContext context) {
    final UpdateButtonDay(:enabledDays, :label, :preSelectedDays) = widget;

    bool preSeleted = preSelectedDays != null && preSelectedDays.contains(label);

    if (preSeleted) {
      selectedButton = true;
    }

    var textColor = selectedButton ? Colors.white : 
       AppColors.colorGrey;

    var buttonColor = selectedButton ? AppColors.colorGreenLight : 
      Colors.white;

    var buttonBorderColor = selectedButton ? AppColors.colorGreen : 
       AppColors.colorGrey;
    
    final bool disableDay = enabledDays != null && !enabledDays.contains(label);

    if (disableDay) {
      buttonColor = Colors.grey[350]!;
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
                  preSelectedDays!.remove(label);
                  preSeleted = false;
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
              fontSize: 12, color: textColor, fontWeight: FontWeight.w500
            ),
          )),
        ),
      ),
    );
  }
}
