import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/helpers/forms_helper.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/core/ui/widgets/hours_widget.dart';
import 'package:tcc_app/src/core/ui/widgets/user_avatar_widget.dart';
import 'package:tcc_app/src/core/ui/widgets/weekdays_widget.dart';
import 'package:tcc_app/src/features/employee/register/employee_register_state.dart';
import 'package:tcc_app/src/features/employee/register/employee_register_vm.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {

  const EmployeeRegisterPage({ super.key });

  @override
  ConsumerState<EmployeeRegisterPage> createState() => _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var isAdm = false;

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  void dispose(){
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final placeAsyncValue = ref.watch(getAdmPlaceProvider);

    ref.listen(
      employeeRegisterVmProvider.select((state) => state.status), (_, status) {
        switch (status) {
          case EmployeeRegisterStateStatus.initial:
            break;

          case EmployeeRegisterStateStatus.success:
            MessagesHelper.showSuccessSnackBar('O Colaborador foi cadastrado com sucesso.', context);
            // Future.delayed(Duration(seconds: 1));
            Navigator.of(context).pop();

          case EmployeeRegisterStateStatus.error:
            MessagesHelper.showErrorSnackBar('Ocorreu um erro. Verifique os dados inseridos e tente novamente.', context);
        }
      }
    );
    
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar novo colaborador'),),
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

                      // const UserAvatarWidget(),
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
                      Row(
                        children: [
                          Checkbox.adaptive(
                            activeColor:AppColors.colorGreen,
                            checkColor: Colors.white,
                            value: isAdm,
                            onChanged: (value) {
                              setState(() {
                                isAdm = !isAdm;
                                employeeRegisterVm.setRegisterADM(isAdm);
                              });
                            }
                          ),
                          const Expanded(
                            child: Text(
                              'Sou administrador e quero me cadastrar como colaborador',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                      Offstage(
                        offstage: isAdm,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
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
                            // const SizedBox(
                            //   height: 24,
                            // ),
                            // TextFormField(
                            //   onTapOutside: (_) => context.unfocus(),
                            //   controller: passwordEC,
                            //   validator: isAdm
                            //       ? null
                            //       : Validatorless.multiple([
                            //           Validatorless.required('A senha é obrigatória'),
                            //           Validatorless.min(
                            //             6,
                            //             'Senha deve conter no mínimo 6 caracteres'
                            //           ),
                            //         ]),
                            //   obscureText: true,
                            //   decoration: const InputDecoration(
                            //     label: Text('Senha')
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      WeekdaysWidget(
                        enabledDays: openingDays,
                        //['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
                        onDayPressed: employeeRegisterVm.addOrRemoveWorkdays
                      ),
              
                      const SizedBox(
                        height: 25,
                      ),
                      HoursWidget(
                        enabledTimes: openingHours,
                        //[ 9, 10, 11, 13, 14, 15, 16, 17, 18],
                        startTime: 8, 
                        endTime: 19, 
                        onHourPressed: employeeRegisterVm.addOrRemoveWorkhours
                      ),
              
                      const SizedBox(
                        height: 25,
                      ),
              
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(55)
                        ),
                        onPressed: (){
                          switch (formKey.currentState?.validate()) {

                            case null || false:
                              MessagesHelper.showErrorSnackBar(
                                'Os campos não foram preenchidos corretamente.Verefique e tente novamente', 
                                context,
                              );

                            case true:
                              final EmployeeRegisterState(
                                workdays: List(isNotEmpty: hasWorkDays),
                                workhours: List(isNotEmpty: hasWorkHours)
                              ) = ref.watch(employeeRegisterVmProvider);

                              if (!hasWorkDays || !hasWorkHours) {
                                MessagesHelper.showErrorSnackBar(
                                  'Por favor, selecione os dias das semana e horário de atendimento para cadastrar', 
                                  context,
                                );
                                return;
                              }

                              final name = nameEC.text;
                              final email = emailEC.text;
                              //final password = passwordEC.text;

                              employeeRegisterVm.register(
                                name: name,
                                email: email,
                                //password: password
                              );
                          }
                        }, 
                        child: Text('Cadastrar')
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
