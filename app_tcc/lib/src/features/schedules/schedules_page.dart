import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/helpers/forms_helper.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/core/ui/widgets/hours_widget.dart';
import 'package:tcc_app/src/core/ui/widgets/user_avatar_widget.dart';
import 'package:tcc_app/src/features/schedules/schedules_state.dart';
import 'package:tcc_app/src/features/schedules/schedules_vm.dart';
import 'package:tcc_app/src/features/schedules/widgets/schedules_calendar.dart';
import 'package:tcc_app/src/models/users_model.dart';
import 'package:validatorless/validatorless.dart';

class SchedulesPage extends ConsumerStatefulWidget {

  const SchedulesPage({ super.key });

  @override
  ConsumerState<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends ConsumerState<SchedulesPage> {

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

    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    final schedulesVm = ref.watch(schedulesVmProvider.notifier);

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
    
    ref.listen(
      schedulesVmProvider.select((state) => state.status),
      (_, status) {
        switch (status) {
          case SchedulesStateStatus.initial:
            break;

          case SchedulesStateStatus.success:
            MessagesHelper.showSuccessSnackBar('O agendamento foi concluido com sucesso!', context);
            Navigator.of(context).pop();
       
          case SchedulesStateStatus.error:
            MessagesHelper.showErrorSnackBar('Ocorreu um erro ao realizar o agendamento.', context);
        
        }
      },
    );

    return Scaffold(
        appBar: AppBar(title: const Text('Novo agendamento'),),
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
                        //showCalendar = !showCalendar;
                      });
                      context.unfocus();
                    },
                    decoration: const InputDecoration(
                      label: Text('Selecione uma data'),
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
                        SchedulesCalendar(
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
                          },
                          workDays: employeeData.workDays,
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
                            schedulesVmProvider.select((state) => state.scheduleTime != null),
                          );
                          if (hourSelected) {
                            schedulesVm.register(
                            userModel: userModel,
                            clientName: clientEC.text,
                          );
          
                          } else {
                            MessagesHelper.showErrorSnackBar('Por favor selecione um horário de atendimento', context);
                          }
                      }
                    },
                    child: const Text('AGENDAR'),
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