import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/defaults_dialogs/confirmation_dialog.dart';
import 'package:tcc_app/src/core/ui/defaults_dialogs/exception_dialog.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/features/employee/mySchedules/appointment_data_source.dart';
import 'package:tcc_app/src/features/employee/mySchedules/employee_schedules_vm.dart';
import 'package:tcc_app/src/features/home/home_employee/home_employee_provider.dart';
import 'package:tcc_app/src/models/users_model.dart';

//DESFAZER ALTERAÇÕES NESSE

class EmployeeSchedulesPage extends ConsumerStatefulWidget {

  const EmployeeSchedulesPage({ super.key });

  @override
  ConsumerState<EmployeeSchedulesPage> createState() => _EmployeeSchedulesPageState();
}

class _EmployeeSchedulesPageState extends ConsumerState<EmployeeSchedulesPage> {
  late DateTime dateSelected;
  var ignoreFirstLoad = true;

  @override
  void initState() {
    super.initState();
    final DateTime(:year, :month, :day) = DateTime.now();
    dateSelected = DateTime(year, month, day, 0, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    //final UserModel(id: userId, :name) = ModalRoute.of(context)!.settings.arguments as UserModel;
    //final UserModel(id: userId, :name) = ModalRoute.of(context)?.settings.arguments as UserModel;
    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    final userId = userModel.id;
    final name = userModel.name;

    final scheduleAsync = ref.watch(
      employeeSchedulesVmProvider(userId, dateSelected)
    );

    deleteScheduleSelected(idScheduleSelected) {
      
      showConfirmationDialog(
        context, 
        isDeleteDialog: true,
        content:"Deseja realmente remover esse agendamento?"
      ).then((value) {
        if(value != null) {
          if (value) {
            final employeeSchedule = ref.read(
              employeeSchedulesVmProvider(userId, dateSelected).notifier,
            );

            employeeSchedule.deleteScheduleVm(idScheduleSelected);
            print('Deletou o agendamento de id ${idScheduleSelected}');
            
            ref.invalidate(getTotalSchedulesTodayProvider(userId));
            ref.invalidate(getTotalSchedulesTomorrowProvider(userId));
            ref.invalidate(employeeSchedulesVmProvider(userId, dateSelected));   
           
          } 
        }
     

      }).catchError((error){
          showExceptionDialog(context, content: 'Ocorreu um erro ao excluir o agendamento.');
      },);

    }

    return Scaffold(
      appBar: AppBar(title: const Text('Agenda de funcionário'),),
        
      body: Column(
        children: [
          const SizedBox(
             height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              name,
              style: const TextStyle(
                color: AppColors.colorGreen,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 50),

          // passa por todos os 3 processos
          scheduleAsync.when(
            loading: () => const AppLoader(),

            error: (e, s) {
              const errorMessage = 'Houve um erro ao carregar os agendamentos.';
              log(errorMessage, error: e, stackTrace: s);
              return const Center(
                child: Text(errorMessage),
              );
            },

            data: (schedules) => Expanded(

              child: SfCalendar(
                allowViewNavigation: true,
                view: CalendarView.day,
                showNavigationArrow: true,
                todayHighlightColor: AppColors.colorGreenLight,
                showDatePickerButton: true,
                showTodayButton: true,
                dataSource: AppointmentDataSource(
                  schedules: schedules
                ),

                onViewChanged: (viewChangedDetails) {
                  if (ignoreFirstLoad) {
                    ignoreFirstLoad = false;
                    return;
                  }

                  // ref.read(
                  //   employeeSchedulesVmProvider(userId, dateSelected).notifier,
                  // ).changeDate(
                  //   userId,
                  //   viewChangedDetails.visibleDates.first,
                  // );

                  final employeeSchedule = ref.read(
                    employeeSchedulesVmProvider(userId, dateSelected).notifier,
                  );

                  employeeSchedule.changeDate(
                    userId,
                    viewChangedDetails.visibleDates.first,
                  );
                },

                onTap: (calendarTapDetails) {
                  if (
                    calendarTapDetails.appointments?.isNotEmpty ?? false
                  ) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        final dateFormat = DateFormat('dd/MM/yyyy  -  HH:mm');
                        return SizedBox(
                          height: 300,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Detalhes do Agendamento',
                                       style: const TextStyle(
                                        color: AppColors.colorGreen,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ),

                                  ],
                                ),

                                const SizedBox(
                                   height: 30,
                                ),

                                Row(
                                  children: [
                                    const SizedBox(
                                       width: 10,
                                    ),
                                    const Text(
                                      'Cliente: ',
                                      style:  TextStyle(
                                        color: AppColors.colorGreen,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // ignore: avoid_dynamic_calls
                                      '${calendarTapDetails.appointments!.first.subject}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                   height: 20,
                                ),
                                
                                Row(
                                  children: [
                                    const SizedBox(
                                       width: 10,
                                    ),
                                    const Text(
                                      'Data e Horário: ',
                                      style: TextStyle(
                                        color: AppColors.colorGreen,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${dateFormat.format(calendarTapDetails.date ?? DateTime.now())}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    )

                                  ],
                                ),
                                const SizedBox(
                                   height: 50,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 15)
                                      ),
                                      onPressed: () {
                                        print(calendarTapDetails.appointments!.first.id);
                                        Navigator.pop(context);
                                        Navigator.of(context).pushNamed(
                                          '/employee/updateSchedule', 
                                          arguments: [userModel, calendarTapDetails.appointments!.first]
                                        );

                                        ref.invalidate(getTotalSchedulesTodayProvider(userId));
                                        ref.invalidate(getTotalSchedulesTomorrowProvider(userId));
                                        ref.invalidate(employeeSchedulesVmProvider(userId, dateSelected));   
                                      },
                                      child: const Text('Editar Agendamento', 
                                        //style: TextStyle(fontSize: 12),
                                      ),
                                    ),

                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        backgroundColor: AppColors.colorRed,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        deleteScheduleSelected(calendarTapDetails.appointments!.first.id);

                                      },
                                      child: const Text('Excluir Agendamento', 
                                      ),
                                    ),
                                   
                                  
                                    
                                  ],
                                ),


                                  // final employeeSchedule = ref.read(
                                  //   employeeSchedulesVmProvider(userId, dateSelected).notifier,
                                  // );

                                  // employeeSchedule.changeDate(
                                  //   userId,
                                  //   viewChangedDetails.visibleDates.first,
                                  // );
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } 
                  // else{
                  //     Navigator.of(context).pushNamed('/employee/schedulesEmployee');
                  // }

                },
              ),

            )
          )
        ],
      ),
    );
  }
}
