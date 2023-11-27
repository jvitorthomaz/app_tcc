import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';

class UpdateHourButton extends StatefulWidget {
  final List<int>? enabledTimes;
  final List<int>? preSelectedTimes;
  final String label;
  final int value;
  final ValueChanged<int> onPressed;
  final bool singleSelection;
  final int? timeSelected;

  const UpdateHourButton({
    super.key,
    this.enabledTimes,
    required this.label,
    required this.value,
    required this.onPressed,
    required this.singleSelection,
    required this.timeSelected, this.preSelectedTimes,
  });

  @override
  State<UpdateHourButton> createState() => _UpdateHourButtonState();
}

class _UpdateHourButtonState extends State<UpdateHourButton> {
  var selected = false;

  @override
  void initState() {
    //var buttonColor = widget.timeSelected ? AppColors.colorGreenLight : Colors.white;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UpdateHourButton(
      :value,
      :label,
      :onPressed,
      :enabledTimes,
      :singleSelection,
      :timeSelected,
      :preSelectedTimes
    ) = widget;
    
    if (singleSelection) {
      if(timeSelected != null && timeSelected == value) {
        selected = true;
        
      } else {
        selected = false;
      }
    }



    bool preSeleted = preSelectedTimes != null && preSelectedTimes.contains(value);

    if (preSeleted) {
      selected = true;
    }

 
    var textColor = selected ? Colors.white : 
       AppColors.colorGrey;

    var buttonColor = selected ? AppColors.colorGreenLight : 
       Colors.white;

    var buttonBorderColor = selected ? AppColors.colorGreen : 
       AppColors.colorGrey;


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
                preSelectedTimes!.remove(value);
                preSeleted  = false;
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
