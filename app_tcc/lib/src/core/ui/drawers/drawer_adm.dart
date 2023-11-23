import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_vm.dart';

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
          return ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                    color: AppColors.colorGreen
                ),
                // currentAccountPicture: const CircleAvatar(
                //   backgroundColor: Colors.white,
                // ),
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
                  await Navigator.of(context).pushNamed('/profile');
                  //showSenhaConfirmacaoDialog(context: context, email: "");
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.person_2_outlined,
                  color: Colors.green,
                ),
                title: const Text("Editar Perfil"),
                onTap: () {
                  //showSenhaConfirmacaoDialog(context: context, email: "");
                },
              ),


              ListTile(
                leading: const Icon(
                  Icons.work,
                  color: Colors.green,
                ),
                title: const Text("Clinica"),
                onTap: () {
                  //showSenhaConfirmacaoDialog(context: context, email: "");
                },
              ),

                ListTile(
                leading: const Icon(
                  Icons.work_outline,
                  color: Colors.green,
                ),
                title: const Text("Editar Clinica"),
                onTap: () {
                  //showSenhaConfirmacaoDialog(context: context, email: "");
                },
              ),



              ListTile(
                leading: const Icon(
                  Icons.key,
                  color: Colors.green,
                ),
                title: const Text("Alterar senha"),
                onTap: () {
                  //showSenhaConfirmacaoDialog(context: context, email: "");
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
                      //showSenhaConfirmacaoDialog(context: context, email: "");
                    },
                  ),


                ],
              ),

              const SizedBox(
                height: 150,
              ),

              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(55),
                    ),
                    onPressed: () async{
                      //Navigator.of(context).pop();
                      await Navigator.of(context).pushNamed('/employee/registerEmployee');
                      ref.invalidate(getMeProvider);  
                      ref.invalidate(homeAdmVmProvider);
                
                    }, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Adicionar Colaborador'),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.person_add),
                      ],
                    ),
                  ),
                ),
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
}
