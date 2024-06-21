import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/features/employee/updateSchedule/update_schedule_vm.dart';
import 'package:tcc_app/src/features/history/user_schedules_history_vm.dart';
import 'package:tcc_app/src/features/history/widgets/update_schedule_note.dart';

class InsertScheduleNote extends ConsumerStatefulWidget {
    final int idUserSelected;
    final int scheduleId;
    final bool alreadyHas;
    final String scheduleNote;

  const InsertScheduleNote({
    Key? key,
    required this.scheduleId,
    required this.idUserSelected,
    required this.alreadyHas,
    required this.scheduleNote
  }) : super(key: key);

  @override
  ConsumerState<InsertScheduleNote> createState() => _InsertScheduleNoteState();
}

class _InsertScheduleNoteState extends ConsumerState<InsertScheduleNote> {

    TextEditingController scheduleNoteController = TextEditingController();
    var obscure = true;

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
              "Insira uma nota sobre o agendamento",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          IconButton(onPressed:() {Navigator.pop(context);}, icon: const Icon(Icons.close,color: AppColors.colorBlack))
        ],
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      content: widget.alreadyHas ?
      const SizedBox(
        height: 150,
        child: Text('Este agendamento já possui uma nota.\nSe desejar, cique para editá-la.'),
      )
      :
      SizedBox(
        height: 250,
        child: Column(
          children: [
           
            TextFormField(
              controller: scheduleNoteController,
              maxLines: 8,
              decoration: const InputDecoration(

              ),
            )
          ],
        ),
      ),
      actions: [
        widget.alreadyHas ?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar", style: TextStyle(fontSize: 18, color: AppColors.colorGreen),),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                backgroundColor: AppColors.colorGreen,
              ),
              onPressed: () async{
                Navigator.of(context).pop();
                await showDialog(context: context, builder: (context) => 
                  UpdateScheduleNote(
                    scheduleId: widget.scheduleId, 
                    idUserSelected: widget.idUserSelected, 
                    scheduleNote: widget.scheduleNote,
                  )
                );
              },
              child: const Text("Editar"),
            ),
          ],
        )
        :
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
              child: const Text("Inserir nota"),
            ),
          ],
        )
      ],
    );
  }
}
