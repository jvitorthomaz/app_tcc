import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/helpers/forms_helper.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/core/ui/widgets/hours_widget.dart';
import 'package:tcc_app/src/features/employee/updateSchedule/update_schedule_state.dart';
import 'package:tcc_app/src/features/employee/updateSchedule/update_schedule_vm.dart';
import 'package:tcc_app/src/features/employee/updateSchedule/widgets/update_schedules_calendar.dart';

import 'package:tcc_app/src/models/schedules_model.dart';
import 'package:tcc_app/src/models/users_model.dart';
import 'package:validatorless/validatorless.dart';

class UpdateSchedulesPage extends ConsumerStatefulWidget {

  const UpdateSchedulesPage({ super.key });

  @override
  ConsumerState<UpdateSchedulesPage> createState() => _UpdateSchedulesPageState();
}

class _UpdateSchedulesPageState extends ConsumerState<UpdateSchedulesPage> {

  var dateFormat = DateFormat('dd/MM/yyyy');
  var showCalendar = false;
  final formKey = GlobalKey<FormState>();
  final clientEC = TextEditingController();
  final dateEC = TextEditingController();

  @override
  void dispose() {
    clientEC.dispose();
    dateEC.dispose();
    super.dispose();
  }
  

   @override
   Widget build(BuildContext context) {
    List<dynamic> args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final userModel = args[0] as UserModel;
    final scheduleModel = args[1] ;


    // final userModel = ModalRoute.of(context)!.settings.arguments[0] as UserModel;
    // final scheduleModel = ModalRoute.of(context)!.settings.arguments as SchedulesModel;

    final schedulesVm = ref.watch(updateSchedulesVmProvider.notifier);

    final employeeData = switch (userModel) {
      AdmUserModel(:final workDays, :final workHours) => (
        workDays: workDays!,
        workHours: workHours!,
      ),

      EmployeeUserModel(:final workDays, :final workHours) => (
        workDays: workDays,
        workHours: workHours,
      ),
    };

      setState(() {
        clientEC.text = scheduleModel.subject;
        //dateEC.text = '${scheduleModel.startTime}';
        //dateEC.text = '${dateFormat.format(scheduleModel.startTime)}';
        // nameEC.text = employeeUserModel.name;
        // emailEC.text = employeeUserModel.email;
        
      });

      // print('------------------------------');
      // print('------------------------------');
      // print('${clientEC.text}--');
      // print('${dateEC.text}-----');
      // print(scheduleModel.id);
      // print('------------------------------');
      // print('------------------------------');


    
    ref.listen(
      updateSchedulesVmProvider.select((state) => state.status),
      (_, status) {
        switch (status) {
          case UpdateSchedulesStateStatus.initial:
            break;

          case UpdateSchedulesStateStatus.success:
            MessagesHelper.showSuccessSnackBar('O agendamento foi editado com sucesso!', context);
            Navigator.of(context).pop();
       
          case UpdateSchedulesStateStatus.error:
            MessagesHelper.showErrorSnackBar('Ocorreu um erro ao editar o agendamento.', context);
        
        }
      },
    );

    return Scaffold(
        appBar: AppBar(title: const Text('Editar agendamento'),),
        body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  // const UserAvatarWidget.withoutButton(),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Text(
                    userModel.name,
                    style: const TextStyle(
                      color: AppColors.colorGreen,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
          
                  TextFormField(
                    controller: clientEC,
                    validator: Validatorless.required('O nome do cliente é obrigatório.'),
                    decoration: const InputDecoration(label: Text('Cliente')),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
          
                  TextFormField(
                    readOnly: true,
                    controller: dateEC,
                    validator: Validatorless.required(
                      'Selecione a data do agendamento'
                    ),
                    onTap: () {
                      setState(() {
                        showCalendar = true;
                        //schedulesVm.deteSelected(scheduleModel.startTime);
                        //showCalendar = !showCalendar;
                      });
                      context.unfocus();
                    },
                    decoration:  InputDecoration(
                      label: Text('${dateFormat.format(scheduleModel.startTime)}', style: TextStyle(color: Colors.black),),
                      hintText: 'Selecione uma data',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: Icon(
                        AppIcons.calendarAppIcon,
                        color: AppColors.colorGreen,
                        size: 20,
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !showCalendar,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 19,
                        ),
                        UpdateSchedulesCalendar(
                          cancelPressed: () {
                            setState(() {
                              showCalendar = false;
                              // showCalendar = !showCalendar;
                            });
                          },
                          onOkPressed: (DateTime value) {
                            
                            setState(() {
                              dateEC.text = dateFormat.format(value);
                              schedulesVm.deteSelected(value);
                              showCalendar = false;
                             
                            });
                              print('------------------------------');
                              print('------------------------------');
                              print('${clientEC.text}--');
                              print('${dateEC.text}-----');
                              print(scheduleModel.id);
                              print('------------------------------');
                              print('------------------------------');
                          },
                          workDays: employeeData.workDays,
                          currentScheduleDay: scheduleModel.startTime, //dateFormat.format(scheduleModel.startTime),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  HoursWidget.singleSelection(
                    startTime: 8,
                    endTime: 19,
                    onHourPressed: schedulesVm.hourSelect,
                    enabledTimes: employeeData.workHours,
                  ),

                  const SizedBox(
                    height: 24,
                  ),
          
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(55)
                    ),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case (false || null):
                        MessagesHelper.showErrorSnackBar('Os dados estão incompletos', context);
          
                        case true:
                          // //   login(emailEC.text, passwordEC.text);
                          final hourSelected = ref.watch(
                            updateSchedulesVmProvider.select((state) => state.scheduleTime != null),
                          );
                          if (hourSelected) {
                            schedulesVm.update(
                            userModel: userModel,
                            clientName: clientEC.text, 
                            scheduleId: scheduleModel.id,
                          );
          
                          } else {
                            MessagesHelper.showErrorSnackBar('Por favor selecione um horário de atendimento', context);
                          }
                      }
                    },
                    child: const Text('EDITAR'),
                  )
                
                ],
                
              ),
            ),
          ),
        ),
        ),
    );
  }
}
