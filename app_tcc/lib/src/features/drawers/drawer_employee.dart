import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_vm.dart';
import 'package:tcc_app/src/repositories/user/auth_repository_impl.dart';

class DrawerEmployee extends ConsumerStatefulWidget {
  final String? userName;
  final String? useEmail;

  const DrawerEmployee({ super.key, this.userName, this.useEmail });

  @override
  ConsumerState<DrawerEmployee> createState() => _DrawerEmployeeState();
}

class _DrawerEmployeeState extends ConsumerState<DrawerEmployee> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    user;
    super.initState();
  }

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
                currentAccountPicture: FirebaseAuth.instance.currentUser!.photoURL != null ?
                CircleAvatar(
                  backgroundImage: (FirebaseAuth.instance.currentUser!.photoURL != null)
                      ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                      : null,
                )
                :
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: AppColors.colorGreen,),
                ),
                decoration: const BoxDecoration(
                    color: AppColors.colorGreen
                ),
                
                accountName: Text(
                  myInfoData.name
                ),
                accountEmail: Text(myInfoData.email),
              ),

              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.green,
                ),
                title: const Text("Perfil"),
                onTap: () async{
                  await Navigator.of(context).pushNamed('/myProfile', arguments: myInfoData);
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.image,
                  color: Colors.green,
                ),
                title: const Text("Alterar foto de perfil"),
                onTap: () async {
                  await Navigator.of(context).pushNamed('/profilePicture', arguments: myInfoData);
                  setState(() {
                    FirebaseAuth.instance.currentUser;
                  });
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.mode_edit,
                  color: Colors.green,
                ),
                title: const Text("Editar meus horários"),
                onTap: () async{
                  Navigator.of(context).pop();
                  await Navigator.of(context).pushNamed('/updateProfile', arguments: myInfoData);
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

              ListTile(
                leading: const Icon(
                  Icons.key,
                  color: Colors.green,
                ),
                title: const Text("Alterar senha"),
                onTap: () async{
                  await Navigator.of(context).pushNamed('/updatePassword');
                  ref.invalidate(getMeProvider);  
                  ref.invalidate(homeAdmVmProvider);
                },
              ),

              Column(
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
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController senhaConfirmacaoController = TextEditingController();
        
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
                  decoration: const InputDecoration(
                    label: Text("Senha"),
                  ),
                )
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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

                        print('Deletou o usuario de id ${idUserSelected}');
                        ref.invalidate(homeAdmVmProvider);
                        Navigator.of(context).pushNamedAndRemoveUntil('/auth/login', (route) => false);

                      }
                    });


                  },
                  child: const Text("EXCLUIR CONTA"),
                ),

              ],
            )
          ],
        );
      },
    );
  }
}
