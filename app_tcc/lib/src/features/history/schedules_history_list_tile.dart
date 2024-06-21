import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/defaults_dialogs/confirmation_dialog.dart';
import 'package:tcc_app/src/core/ui/defaults_dialogs/exception_dialog.dart';
import 'package:tcc_app/src/features/employee/mySchedules/employee_schedules_vm.dart';
import 'package:tcc_app/src/features/history/user_schedules_history_vm.dart';
import 'package:tcc_app/src/features/history/widgets/insert_schedule_note.dart';
import 'package:tcc_app/src/features/history/widgets/show_schedule_note.dart';
import 'package:tcc_app/src/features/history/widgets/update_schedule_note.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_vm.dart';
import 'package:tcc_app/src/features/home/home_employee/home_employee_provider.dart';
import 'package:tcc_app/src/models/schedules_model.dart';
import 'package:tcc_app/src/models/users_model.dart';

enum SampleItem {itemOne, itemTwo, itemThree, itemFour}


class SchedulesHistoryListTile extends ConsumerStatefulWidget {

  final SchedulesModel schedules;
  final int userId;

  const SchedulesHistoryListTile( {
    super.key,
    required this.schedules,
    required this.userId,
  });

  @override
  ConsumerState<SchedulesHistoryListTile> createState() => _SchedulesHistoryListTileState();
}

class _SchedulesHistoryListTileState extends ConsumerState<SchedulesHistoryListTile> {


  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeAdmVmProvider);
    final me = ref.watch(getMeProvider);
    var dateFormat = DateFormat('dd/MM/yyyy');

      deleteScheduleSelected(idScheduleSelected) {
      
      showConfirmationDialog(
        context, 
        isDeleteDialog: true,
        content:"Deseja realmente remover esse agendamento?"
      ).then((value) {
        if(value != null) {
          if (value) {
            final employeeSchedule = ref.read(
              userSchedulesHistoryVmProvider(widget.userId).notifier,
            );

            employeeSchedule.deleteScheduleVm(idScheduleSelected);
            print('Deletou o agendamento de id ${idScheduleSelected}');
            
            ref.invalidate(userSchedulesHistoryVmProvider);
           
          } 
        }
     

      }).catchError((error){
          showExceptionDialog(context, content: 'Ocorreu um erro ao excluir o agendamento.');
      },);

    }

    return Container(
      width: 260, 
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.colorGreen, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.schedules.clientName,
                        overflow: TextOverflow.ellipsis,
                        //maxLines: 2,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    PopupMenuButton<SampleItem>(
                      color: Colors.white,
                      enableFeedback: true,
                      surfaceTintColor: Colors.white,
                      padding: EdgeInsets.zero,
                      position: PopupMenuPosition.under,
                      icon: const Icon(Icons.more_vert, color: AppColors.colorGreen),

                      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                        PopupMenuItem<SampleItem>(
                          value: SampleItem.itemOne,
                          child: ListTile(
                            onTap: () async{
                              Navigator.of(context).pop();
                              await showDialog(context: context, builder: (context) => 
                                ShowScheduleNote(
                                  scheduleId: widget.schedules.id, 
                                  idUserSelected: widget.userId, 
                                  scheduleNote: widget.schedules.scheduleNote!, 
                                  clientName: widget.schedules.clientName,

                                )
                              );
                            },
                             leading: const Icon(
                              Icons.description_outlined,
                              size: 24,
                              color: AppColors.colorGreen,
                            ),
                            title: const Text(
                              'Ver nota ',
                              style: TextStyle(color: AppColors.colorGreen, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),

                        PopupMenuItem<SampleItem>(
                          value: SampleItem.itemTwo,
                          child: ListTile(
                            onTap: () async{
                              Navigator.of(context).pop();
                              await showDialog(context: context, builder: (context) => 
                                InsertScheduleNote(
                                  scheduleId: widget.schedules.id, 
                                  idUserSelected: widget.userId, 
                                  alreadyHas: widget.schedules.scheduleNote!.isEmpty ? false : true,
                                  scheduleNote: widget.schedules.scheduleNote!, 
                                )
                              );
                              ref.invalidate(userSchedulesHistoryVmProvider);
                            },
                             leading: const Icon(
                              AppIcons.editIcon,
                              size: 18,
                              color: AppColors.colorGreen,
                            ),
                            title: const Text(
                              'Inserir nota sobre agendamento',
                              //'Editar Colaborador',
                              style: TextStyle(color: AppColors.colorGreen, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      
                        PopupMenuItem<SampleItem>(
                          value: SampleItem.itemFour,
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                               deleteScheduleSelected(widget.schedules.id);
                            },
                            leading: const Icon(
                              AppIcons.trashIcon,
                              size: 18,
                              color: AppColors.colorRed,
                            ),
                            title: const Text(
                              'Excluir agendamento',
                              style: TextStyle(color: AppColors.colorRed, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'Data: ${dateFormat.format(widget.schedules.date)}',
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Horário: ${widget.schedules.hour}:00',
                  overflow: TextOverflow.ellipsis,
                  //maxLines: 2,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
