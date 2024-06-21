import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/features/employee/updateSchedule/update_schedule_vm.dart';
import 'package:tcc_app/src/features/history/user_schedules_history_vm.dart';

class UpdateScheduleNote extends ConsumerStatefulWidget {

    final int idUserSelected;
    final int scheduleId;
    final String scheduleNote;

  const UpdateScheduleNote({
    Key? key,
    required this.scheduleId,
    required this.idUserSelected,
    required this.scheduleNote,
  }) : super(key: key);

  @override
  ConsumerState<UpdateScheduleNote> createState() => _UpdateScheduleNoteState();
}

class _UpdateScheduleNoteState extends ConsumerState<UpdateScheduleNote> {

  TextEditingController scheduleNoteController = TextEditingController();
  var obscure = true;
 
 @override
  void initState() {
    scheduleNoteController.text = widget.scheduleNote;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final updateSchedulesVm = ref.watch(updateSchedulesVmProvider.notifier);
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           const Expanded(
            child: Text(
              "Edite nota sobre o agendamento",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          IconButton(onPressed:() {Navigator.pop(context);}, icon: const Icon(Icons.close,color: AppColors.colorBlack))
        ],
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      content: 
      SizedBox(
        height: 250,
        child: Column(
          children: [
            TextFormField(
              controller: scheduleNoteController,
              maxLines: 8,
              decoration: const InputDecoration(),
            )
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                backgroundColor: AppColors.colorGreen,
              ),
              onPressed: () async {
                await updateSchedulesVm.insertScheduleNote(
                  note: scheduleNoteController.text,
                  scheduleId: widget.scheduleId
                );
                ref.invalidate(userSchedulesHistoryVmProvider);
                Navigator.of(context).pop();
              },
              child: const Text("Editar nota"),
            ),
          ],
        )
      ],
    );
  }
}
