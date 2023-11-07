import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/ui/helpers/forms_helper.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/core/ui/widgets/hours_widget.dart';
import 'package:tcc_app/src/core/ui/widgets/weekdays_widget.dart';
import 'package:tcc_app/src/features/auth/register/register_clinic/place_register_state.dart';
import 'package:tcc_app/src/features/auth/register/register_clinic/place_register_vm.dart';
import 'package:validatorless/validatorless.dart';

class PlaceRegisterPage extends ConsumerStatefulWidget {

  const PlaceRegisterPage({ super.key });

  @override
  ConsumerState<PlaceRegisterPage> createState() => _PlaceRegisterPageState();
}

class _PlaceRegisterPageState extends ConsumerState<PlaceRegisterPage> {

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
    final placeRegisterVm = ref.watch(placeRegisterVmProvider.notifier);

    ref.listen(placeRegisterVmProvider, (_, state) {
      switch (state.status) {
        case PlaceRegisterStateStatus.initial:
          break;

        case PlaceRegisterStateStatus.error:
          MessagesHelper.showErrorSnackBar('Desculpe, houve um erro ao registrar sua clínica', context);

        case PlaceRegisterStateStatus.success:
          Navigator.of(context).pushNamedAndRemoveUntil('/home/admUser', (route) => false);
          break;
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar estabelecimento'),),
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
                onTapOutside: (_) => context.unfocus(),
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
                onTapOutside: (_) => context.unfocus(),
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
                onDayPressed: (String value) {
                  placeRegisterVm.addOrRemoveOpenDay(value);
                  print('Dia Selecionado: $value');
                },
              ),
              const SizedBox(
                 height: 25,
              ),
          
              HoursWidget(
                startTime: 8, 
                endTime: 19, 
                onHourPressed: (int value){
                  placeRegisterVm.addOrRemoveOpenHour(value);
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
                    placeRegisterVm.register(
                      name: nameEC.text,
                      email: emailEC.text,
                    );
                  }
                }, 
                child: const Text('CADASTRAR'),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}