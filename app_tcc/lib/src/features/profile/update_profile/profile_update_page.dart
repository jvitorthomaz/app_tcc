import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/helpers/forms_helper.dart';
import 'package:tcc_app/src/core/ui/helpers/messages_helper.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/core/ui/widgets/hours_widget.dart';
import 'package:tcc_app/src/core/ui/widgets/weekdays_widget.dart';
import 'package:tcc_app/src/features/profile/update_profile/profile_update_state.dart';
import 'package:tcc_app/src/features/profile/update_profile/profile_update_vm.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:tcc_app/src/models/users_model.dart';
import 'package:validatorless/validatorless.dart';

class ProfileUpdatePage extends ConsumerStatefulWidget {

  const ProfileUpdatePage({ super.key });

  @override
  ConsumerState<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends ConsumerState<ProfileUpdatePage> {

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  bringData(UserModel userModel){

  }


  // @override
  // void initState() {
  //   super.initState();
  //   bringData(userModel);
  // }

  void dispose(){
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    final profileUpdateVm = ref.watch(profileUpdateVmProvider.notifier);
    final placeAsyncValue = ref.read(getAdmPlaceProvider);
    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
      setState(() {
        nameEC.text = userModel.name;
        emailEC.text = userModel.email;
        
      });
      print('${userModel.id}');
      print('${nameEC.text}');
      print('${emailEC.text}');
    // nameEC.text = userModel.name;
    // emailEC.text = userModel.email;
    
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    // final userModel = ref.watch(getMeProvider.future);
    //final employeeUserModel = ModalRoute.of(context)!.settings.arguments as EmployeeUserModel;

    final userData = switch (userModel) {
      AdmUserModel(:final workDays, :final workHours) => (
        workDays: workDays!,
        workHours: workHours!,
      ),

      EmployeeUserModel(:final workDays, :final workHours) => (
        workDays: workDays,
        workHours: workHours,
      ),

    };

    // final profileUpdateVm = ref.watch(profileUpdateVmProvider.notifier);
    // final placeAsyncValue = ref.watch(getAdmPlaceProvider);

    ref.listen(
      profileUpdateVmProvider.select((state) => state.status), (_, status) {
        switch (status) {
          case ProfileUpdateStateStatus.initial:
            break;

          case ProfileUpdateStateStatus.success:
            MessagesHelper.showSuccessSnackBar('O seu perfil foi editado com sucesso.', context);
            // Future.delayed(Duration(seconds: 1));
            Navigator.of(context).pop();

          case ProfileUpdateStateStatus.error:
            MessagesHelper.showErrorSnackBar('Ocorreu um erro. Verifique os dados inseridos e tente novamente.', context);
        }
      }
    );
    
    return Scaffold(
      appBar: AppBar(title: const Text('Editar perfil'),),
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
          return 
          SingleChildScrollView(
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
                      Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            readOnly: true,
                            //onTapOutside: (_) => context.unfocus(),
                            controller: nameEC,
                            validator: Validatorless.required('Nome obrigatório'),
                            decoration: const InputDecoration(
                              label: Text('Nome')
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            readOnly: true,
                            //onTapOutside: (_) => context.unfocus(),
                            controller: emailEC,
                            validator: Validatorless.multiple([
                                    Validatorless.required('E-mail obrigatório'),
                                    Validatorless.email('O E-mail digitado é inválido')
                                  ]),
                            decoration: const InputDecoration(
                              label: Text('E-mail')
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      WeekdaysWidget(
                        enabledDays: openingDays,
                        //['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
                        onDayPressed: profileUpdateVm.addOrRemoveWorkdays //TIRAR
                      ),
              
                      const SizedBox(
                        height: 25,
                      ),
                      HoursWidget(
                        enabledTimes: openingHours,
                        //[ 9, 10, 11, 13, 14, 15, 16, 17, 18],
                        startTime: 8, 
                        endTime: 19, 
                        onHourPressed: profileUpdateVm.addOrRemoveWorkhours //TIRAR
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
                              //handleConfirmWithPassword(height, width);

                              final ProfileUpdateState(
                                workdays: List(isNotEmpty: hasWorkDays),
                                workhours: List(isNotEmpty: hasWorkHours)
                              ) = ref.watch(profileUpdateVmProvider);

                              if (!hasWorkDays || !hasWorkHours) {
                                MessagesHelper.showErrorSnackBar(
                                  'Por favor, selecione os dias das semana e horário de atendimento.', 
                                  context,
                                );
                                return;
                              }

                              final name = nameEC.text;
                              final email = emailEC.text;

                              //final password = passwordEC.text;

                              await profileUpdateVm.update(
                                userId: userModel.id,
                                name: name,
                                email: email,
                                //password: password
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



  handleConfirmWithPassword(height, width) {
    // return Theme(
    //       data: ThemeData(dialogBackgroundColor: Colors.white),
    String password = passwordEC.text;
    
    return showDialog(
      context: context,
      builder: (context) {
        TextEditingController confirmacaoSenhaController =
          TextEditingController(text: password);
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          child: AlertDialog(
            insetPadding: EdgeInsets.all(10),
            backgroundColor:Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Redefinição de senha",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.colorBlack,
                  ),
                ),
                IconButton(onPressed:() {Navigator.pop(context);}, icon: const Icon(Icons.close,color: AppColors.colorBlack))
              ],
            ),
            content: SizedBox(
              //width: 300,
              height: 70,
              width: width *0.9,
              child: Column(
                children: [
                  const SizedBox(
                     height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.colorBlack,
                    ),
                    controller: confirmacaoSenhaController,
                    decoration: const InputDecoration(
                      label: Text("Confirme seu e-mail"),
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            actions: [
              Column(
                children: [
                  const SizedBox(
                     height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                    onPressed: (){
                      
                      //   authRepository
                      //     .redefinicaoSenha(email: redefincaoSenhaController.text)
                      //     .then((String? erro) {
        
                      //   if (erro == null) {
                      //     showSnackBar(
                      //       context: context,
                      //       mensagem: "E-mail de redefinição enviado!",
                      //       isErro: false,
                      //     );
        
                      //   } else {
                      //     showSnackBar(context: context, mensagem: erro);
                      //   }
        
                      //   Navigator.pop(context);
                      // });
                     
        
                    }, 
                    child: Text(
                    'Confirmar', style: TextStyle(
                        fontSize: 16,)
                    
                    ),
                  ),
                  const SizedBox(
                     height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // authRepository
                      //     .redefinicaoSenha(email: redefincaoSenhaController.text)
                      //     .then((String? erro) {
                      //   if (erro == null) {
                      //     showSnackBar(
                      //       context: context,
                      //       mensagem: "E-mail de redefinição enviado!",
                      //       isErro: false,
                      //     );
                      //   } else {
                      //     showSnackBar(context: context, mensagem: erro);
                      //   }
        
                      //   Navigator.pop(context);
                      // });
                    },
                    child: const Text(
                      "Voltar",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.colorBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        
      },
    );   
  }
}
