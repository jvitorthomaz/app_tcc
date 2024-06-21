import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/helpers/forms_helper.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/core/ui/widgets/hours_widget.dart';
import 'package:tcc_app/src/core/ui/widgets/update_hours_widget.dart';
import 'package:tcc_app/src/core/ui/widgets/weekdays_widget.dart';
import 'package:tcc_app/src/features/employee/register/employee_register_state.dart';
import 'package:tcc_app/src/features/employee/register/employee_register_vm.dart';
import 'package:tcc_app/src/features/employee/updateEmployee/employee_update_state.dart';
import 'package:tcc_app/src/features/employee/updateEmployee/employee_update_vm.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:tcc_app/src/models/users_model.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeUpdatePage extends ConsumerStatefulWidget {

  const EmployeeUpdatePage({ super.key });

  @override
  ConsumerState<EmployeeUpdatePage> createState() => _EmployeeUpdatePageState();
}

class _EmployeeUpdatePageState extends ConsumerState<EmployeeUpdatePage> {
  var isAdm = false;

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  bringData(UserModel userModel){

  }

  void dispose(){
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;

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
        nameEC.text = userModel.name;
        emailEC.text = userModel.email;

      });
      print('${nameEC.text}--');
      print('${emailEC.text}-----');

    final employeeUpdateVm = ref.watch(employeeUpdateVmProvider.notifier);
    final placeAsyncValue = ref.watch(getAdmPlaceProvider);

    ref.listen(
      employeeUpdateVmProvider.select((state) => state.status), (_, status) {
        switch (status) {
          case EmployeeUpdateStateStatus.initial:
          
            break;

          case EmployeeUpdateStateStatus.success:
            MessagesHelper.showSuccessSnackBar('O Colaborador foi editado com sucesso.', context);
            Navigator.of(context).pop();

          case EmployeeUpdateStateStatus.error:
            MessagesHelper.showErrorSnackBar('Ocorreu um erro. Verifique os dados inseridos e tente novamente.', context);
        }
      }
    );
    
    return Scaffold(
      appBar: AppBar(title: const Text('Editar colaborador'),),
      body: placeAsyncValue.when(
        error: (error, stackTrace) {
          log(
            'Erro ao carregar a página',
            error: error, 
            stackTrace: stackTrace
          );
              return const Center(
                child: Column(
                  children: [
                    Icon(Icons.info_outline, size: 50,),
                    Text('Erro ao carregar a página'),
                  ],
                ),
              );
        }, 
        loading: () => const AppLoader(),
        data: (placeModel){
          final PlaceModel(:openingDays, :openingHours) = placeModel;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        'MyClinic App', 
                        style: TextStyle(
                          color: AppColors.colorGreenLight, 
                          fontSize: 30, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Offstage(
                        offstage: isAdm,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              readOnly: true,
                              onTapOutside: (_) => context.unfocus(),
                              controller: nameEC,
                              validator: isAdm
                                  ? null
                                  : Validatorless.required('Nome obrigatório'),
                              decoration: const InputDecoration(
                                label: Text('Nome')
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              readOnly: true,
                              onTapOutside: (_) => context.unfocus(),
                              controller: emailEC,
                              validator: isAdm
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required('E-mail obrigatório'),
                                      Validatorless.email('O E-mail digitado é inválido')
                                    ]),
                              decoration: const InputDecoration(
                                label: Text('E-mail')
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      WeekdaysWidget(
                        enabledDays: openingDays,
                        onDayPressed: employeeUpdateVm.addOrRemoveWorkdays //TIRAR
                      ),
              
                      const SizedBox(
                        height: 25,
                      ),
                      HoursWidget(
                        enabledTimes: openingHours,
                        startTime: 8, 
                        endTime: 19, 
                        onHourPressed: employeeUpdateVm.addOrRemoveWorkhours //TIRAR
                      ),
              
                      const SizedBox(
                        height: 25,
                      ),
              
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(55)
                        ),
                        onPressed: () async {
                          switch (formKey.currentState?.validate()) {

                            case null || false:
                              MessagesHelper.showErrorSnackBar(
                                'Os campos não foram preenchidos corretamente.Verefique e tente novamente', 
                                context,
                              );

                            case true:
                              final EmployeeUpdateState(
                                workdays: List(isNotEmpty: hasWorkDays),
                                workhours: List(isNotEmpty: hasWorkHours)
                              ) = ref.watch(employeeUpdateVmProvider);

                              if (!hasWorkDays || !hasWorkHours) {
                                MessagesHelper.showErrorSnackBar(
                                  'Por favor, selecione os dias das semana e horário de atendimento.', 
                                  context,
                                );
                                return;
                              }

                              final name = nameEC.text;
                              final email = emailEC.text;

                              await employeeUpdateVm.update(
                                employeeId: userModel.id,
                                name: name,
                                email: email,
                              );
                             Navigator.of(context).pop();
                          }
                        }, 
                        child: const Text('Alterar'),
                      )
                      
              
                    ],
                  ),
                ),
              ),
            )
          );
        },
      )
    );
  }
}
