import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_vm.dart';
import 'package:tcc_app/src/repositories/user/auth_repository_impl.dart';

class DrawerAdm extends ConsumerStatefulWidget {
  final String? userName;
  final String? useEmail;

  const DrawerAdm({ super.key, this.userName, this.useEmail });

  @override
  ConsumerState<DrawerAdm> createState() => _DrawerAdmState();
}

class _DrawerAdmState extends ConsumerState<DrawerAdm> {

  @override
  Widget build(BuildContext context) {
    final clinicInfo = ref.watch(getAdmPlaceProvider);
    final myInfo = ref.watch(getMeProvider);

    return Drawer(
      child: myInfo.maybeWhen(
        data: (myInfoData) {
          return Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                    color: AppColors.colorGreen
                ),
                accountName: Text(
                  myInfoData.name
                ),
                accountEmail: Text(myInfoData.email),
                
                //arrowColor: Colors.black,
              ),

              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.green,
                ),
                title: const Text("Perfil"),
                onTap: () async{
                  await Navigator.of(context).pushNamed('/myProfile', arguments: myInfoData);
                  //showSenhaConfirmacaoDialog(context: context, email: "");
                },
              ),

              ListTile(
                leading: const Icon(
                  // Icons.person_2_outlined,
                  Icons.mode_edit,
                  color: Colors.green,
                ),
                title: const Text("Editar meus horários"),
                //  title: const Text("Editar Perfil"),
                onTap: () async{
                  //Navigator.of(context).pop();
                  await Navigator.of(context).pushNamed('/updateProfile', arguments: myInfoData);
                  ref.invalidate(getMeProvider);  
                  ref.invalidate(homeAdmVmProvider);
                   
                  //showSenhaConfirmacaoDialog(context: context, email: "");
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.work,
                  color: Colors.green,
                ),
                title: const Text("Clínica"),
                onTap: () async{
                  await Navigator.of(context).pushNamed('/userClinicProfile',);
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.history,
                  color: Colors.green,
                ),
                title: const Text("Histórico de agendamentos"),
                onTap: () async{
                  await Navigator.of(context).pushNamed('/userSchedulesHistory', arguments: myInfoData);
                },
              ),

              //   ListTile(
              //   leading: const Icon(
              //     // Icons.work_outline,
              //     Icons.edit,
              //     color: Colors.green,
              //   ),
              //   title: const Text("Editar Clínica"),
              //   onTap: () async{
              //     await Navigator.of(context).pushNamed('/updateClinic', arguments: clinicInfo);
              //   },
              // ),

              ListTile(
                leading: const Icon(
                  Icons.key,
                  color: Colors.green,
                ),
                title: const Text("Alterar senha"),
                onTap: () async{
                  //Navigator.of(context).pop();
                  await Navigator.of(context).pushNamed('/updatePassword');
                },
              ),

              Column(
                ///mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ListTile(
                    leading: const Icon(
                      AppIcons.exitAppIcon,
                      color: AppColors.colorGreen,
                      size: 32,
                    ),
                    title: const Text("Sair"),
                    onTap: () {
                      ref.read(homeAdmVmProvider.notifier).logout();
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    title: const Text("Remover conta"),
                    onTap: () {
                      print("${myInfoData.id}");
                      showPasswordConfirmationDeleteDialog(
                        context: context, 
                        email: "",
                        idUserSelected: myInfoData.id, 

                      );


                    },
                  ),
                ],
              ),

              // const SizedBox(
              //   height: 200,
              // ),

              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: 
                    InkWell(
                      onTap: () async{
                        //Navigator.of(context).pop();
                        await Navigator.of(context).pushNamed('/employee/registerEmployee');
                        ref.invalidate(getMeProvider);  
                        ref.invalidate(homeAdmVmProvider);
                      },
                      child:  const Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.person_add, color: AppColors.colorGreen,size: 22),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Adicionar Colaborador', 
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.colorGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(Icons.chevron_right, color: AppColors.colorGreen, size: 24,),
                        ],
                      ),
                    ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     minimumSize: Size.fromHeight(55),
                  //   ),
                  //   onPressed: () async{
                  //     //Navigator.of(context).pop();
                  //     await Navigator.of(context).pushNamed('/employee/registerEmployee');
                  //     ref.invalidate(getMeProvider);  
                  //     ref.invalidate(homeAdmVmProvider);
                
                  //   }, 
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text('Adicionar Colaborador'),
                  //       const SizedBox(
                  //         width: 5,
                  //       ),
                  //       Icon(Icons.person_add),
                  //     ],
                  //   ),
                  // ),
                ),
              ),
              const SizedBox(
                 height: 50,
              ),
            ],
          );
        }, 
        orElse: () { 
          return const Center(
            child: AppLoader(),
          );
        }
      )
    );
  }
  showPasswordConfirmationDeleteDialog({
    required BuildContext context,
    required String email,
    required int idUserSelected,
  }) {
    //var obscure = true;
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController senhaConfirmacaoController = TextEditingController();
        var obscure = true;
        
        return AlertDialog(
              title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children: [
                const Text(
                  "ATENÇÃO!",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorRed,
                    ),
                ),
                IconButton(onPressed:() {Navigator.pop(context);}, icon: const Icon(Icons.close,color: AppColors.colorBlack))
              ],
            ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))
          ),
          content: SizedBox(
            //width: width,
            height: 280,
            child: Column(
              children: [
                const Text("Você esta excluindo sua própria conta!\nEssa ação é irreversível e você perderá acesso à sua clínica! \nVocê deseja realmente executar essa operação?\n", style: TextStyle(fontSize: 14, ), textAlign: TextAlign.justify,),
                const Text(
                  "Para confirmar a remoção da conta, insira sua senha:\n"
                ),
                TextFormField(
                  controller: senhaConfirmacaoController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("Senha"),
                    // suffixIcon: IconButton(
                    //   onPressed: () => setState(() => obscure = !obscure),
                    //   icon: Icon(
                    //     obscure ? Icons.visibility : Icons.visibility_off,
                    //     color: AppColors.colorGreen,
                    //   )
                    // ),
                  ),
                )
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // OutlinedButton(
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(horizontal: 20)
                //   ),
                //   onPressed: () {
                //       Navigator.pop(context, false);
                //   },
                //   child: const Text('CENCELAR'),
                // ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.of(context).pop();
                
                    
                //   },
                //   child: const Text("Cancelar", style: TextStyle(fontSize: 18, color: AppColors.colorGreen),),
                // ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    backgroundColor: AppColors.colorRed,
                  ),
                  onPressed: () {

                    AuthRepositoryImpl()
                      .removerConta(senha: senhaConfirmacaoController.text)
                      .then((String? erro) {
                      if (erro == null) {
                                  
                        ref.read(homeAdmVmProvider.notifier).deleteUserVm(idUserSelected);

                        //employeeSchedule.deleteScheduleVm(idScheduleSelected);
                        print('Deletou o usuario de id ${idUserSelected}');
                      // ref.invalidate(getMeProvider);  
                        ref.invalidate(homeAdmVmProvider);
                        Navigator.of(context).pushNamedAndRemoveUntil('/auth/login', (route) => false);
                        //Navigator.pop(context);
                      }
                    });


                  },
                  child: const Text("EXCLUIR CONTA"),
                ),


                // TextButton(
                //   onPressed: () {

                //     AuthRepositoryImpl()
                //       .removerConta(senha: senhaConfirmacaoController.text)
                //       .then((String? erro) {
                //       if (erro == null) {
                                  
                //         ref.read(homeAdmVmProvider.notifier).deleteUserVm(idUserSelected);

                //         //employeeSchedule.deleteScheduleVm(idScheduleSelected);
                //         print('Deletou o usuario de id ${idUserSelected}');
                //       // ref.invalidate(getMeProvider);  
                //         ref.invalidate(homeAdmVmProvider);
                //         Navigator.pop(context);
                //       }
                //     });
                    
                //   },
                //   child: const Text("EXCLUIR CONTA"),
                // ),
              ],
            )
          ],
        );
      },
    );
  }
}
