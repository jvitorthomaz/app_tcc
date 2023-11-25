
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/helpers/forms_helper.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/core/ui/widgets/hours_widget.dart';
import 'package:tcc_app/src/core/ui/widgets/weekdays_widget.dart';
import 'package:tcc_app/src/features/clinic/update_clinic_adm/place_update_state.dart';
import 'package:tcc_app/src/features/clinic/update_clinic_adm/place_update_vm.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:validatorless/validatorless.dart';

class PlaceUpdatePage extends ConsumerStatefulWidget {

  const PlaceUpdatePage({ super.key });

  @override
  ConsumerState<PlaceUpdatePage> createState() => _PlaceUpdatePageState();
}

class _PlaceUpdatePageState extends ConsumerState<PlaceUpdatePage> {

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  void dispose(){
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

   @override
   Widget build(BuildContext context) {
    final placeUpdateVm = ref.watch(placeUpdateVmProvider.notifier);
    //final clinicInfo = ref.watch(getAdmPlaceProvider);

    final clinicData = ModalRoute.of(context)!.settings.arguments as PlaceModel;

      setState(() {
        nameEC.text = clinicData.name;
        emailEC.text = clinicData.email;
        // nameEC.text = employeeUserModel.name;
        // emailEC.text = employeeUserModel.email;
        
      });
      print('${nameEC.text}--');
      print('${emailEC.text}-----');
      print("${clinicData.id}");

    ref.listen(placeUpdateVmProvider, (_, state) {
      switch (state.status) {
        case PlaceUpdateStateStatus.initial:
          break;

        case PlaceUpdateStateStatus.error:
          MessagesHelper.showErrorSnackBar('Desculpe, houve um erro ao atualizar sua clínica', context);

        case PlaceUpdateStateStatus.success:
          Navigator.of(context).pop();
          break;
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Editar estabelecimento'),),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
            children: [
              const SizedBox(
                  height: 15,
              ),
          
          
              TextFormField(
                //onTapOutside: (_) => context.unfocus(),
                controller: nameEC,
                validator: Validatorless.required('O Nome é obrigatório'),
                decoration: const InputDecoration(
                  label: Text('Nome')
                ),
              ),
          
              const SizedBox(
                 height: 25,
              ),
          
          
              TextFormField(
                //onTapOutside: (_) => context.unfocus(),
                controller: emailEC,
                validator: Validatorless.multiple([
                  Validatorless.required('O E-mail é obrigatório'),
                  Validatorless.email('O E-mail inserido é inválido')
                ]),
                decoration: const InputDecoration(
                  label: Text('E-mail')
                ),
              ),
          
              const SizedBox(
                 height: 25,
              ),
          
              WeekdaysWidget(
                //enabledDays: clinicData.openingDays,
                onDayPressed: (String value) {
                  placeUpdateVm.addOrRemoveOpenDay(value);
                  print('Dia Selecionado: $value');
                },
              ),
              const SizedBox(
                 height: 25,
              ),
          
              HoursWidget(
                //enabledTimes: clinicData.openingHours,
                startTime: 8, 
                endTime: 19, 
                onHourPressed: (int value){
                  placeUpdateVm.addOrRemoveOpenHour(value);
                  print('Hora Selecionada: $value');
                }
              ),
              const SizedBox(
                 height: 25,
              ),
          
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(55)
                ),
                onPressed: () {
                  switch (formKey.currentState?.validate()) {
                    case null || false:
                     MessagesHelper.showErrorSnackBar('O Campos digitados estão inválidos', context);

                    case true:
                    placeUpdateVm.update(
                      placeId: clinicData.id,
                      name: nameEC.text,
                      email: emailEC.text,
                    );
                  }
                }, 
                child: const Text('EDITAR'),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
