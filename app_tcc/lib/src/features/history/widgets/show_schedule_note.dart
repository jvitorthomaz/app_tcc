import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/features/employee/updateSchedule/update_schedule_vm.dart';

class ShowScheduleNote extends ConsumerStatefulWidget {
    final int idUserSelected;
    final int scheduleId;
    final String? scheduleNote;
    final String clientName;

  const ShowScheduleNote({
    Key? key,
    required this.scheduleId,
    required this.idUserSelected,
    required this.scheduleNote,
    required this.clientName
  }) : super(key: key);

  @override
  ConsumerState<ShowScheduleNote> createState() => _ShowScheduleNoteState();
}

class _ShowScheduleNoteState extends ConsumerState<ShowScheduleNote> {

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
           Expanded(
            child: Text(
              "Agendamento de ${widget.clientName}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close, color: AppColors.colorBlack),
          )
        ],
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      content: SizedBox(
        //width: width,
        //height: 250,
        child: widget.scheduleNote!.isEmpty ?
          const Text('Este agendamento ainda não possui uma nota')
          :
          Container(
            width: 260,
            //height: 120,
            //margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.colorGreen, width: 2),
            ),
            child:
                Text('${widget.scheduleNote}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),)
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
              onPressed: () {
                Navigator.of(context).pop();

              },
              child: const Text("Voltar"),
            ),
          ],
        )
      ],
    );
  }
}
