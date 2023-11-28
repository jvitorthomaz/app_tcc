import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/defaults_dialogs/delete_employee_dialog.dart';
import 'package:tcc_app/src/core/ui/defaults_dialogs/exception_dialog.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_vm.dart';
import 'package:tcc_app/src/models/users_model.dart';

enum SampleItem {itemOne, itemTwo, itemThree,}


class HomeListEmployeeTile extends ConsumerStatefulWidget {

  final UserModel employee;
  //final EmployeeUserModel? test;//

  const HomeListEmployeeTile({
    super.key,
    required this.employee,
    //this.test,//
  });

  @override
  ConsumerState<HomeListEmployeeTile> createState() => _HomeListEmployeeTileState();
}

class _HomeListEmployeeTileState extends ConsumerState<HomeListEmployeeTile> {


  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeAdmVmProvider);
    final me = ref.watch(getMeProvider);

    deleteUser(idUserSelected, profile) {
      bool isCurrentUser = false;
      //   if(me case UserModel(:final id)) {
      //     isCurrentUser == true;
      //   }
      me.maybeWhen(
        data: (meData){
          meData.id.toString() == idUserSelected.toString() ?
           isCurrentUser = true 
          :
           isCurrentUser = false;
          
        },
        orElse:(){
          showExceptionDialog(context, content: 'Ocorreu um erro ao excluir o agendamento.');
        }
      );

      isCurrentUser  ?
        showDeleteEmployeeDialog(
          context, 
          isAdmUser: true,
          
        )
      :
        showDeleteEmployeeDialog(
          context, 
          isAdmUser: false,
          content: "Você esta excluindo um colaborador da sua clínica! Essa ação é irreversível! \n\nVocê deseja realmente executar essa operação?"
        ).then((value) {
          if(value != null) {
            if (value) {
          
              ref.read(homeAdmVmProvider.notifier).deleteUserVm(idUserSelected);

              //employeeSchedule.deleteScheduleVm(idScheduleSelected);
              print('Deletou o usuario de id ${idUserSelected}');
            // ref.invalidate(getMeProvider);  
              ref.invalidate(homeAdmVmProvider);
              
              // ref.invalidate(getTotalSchedulesTodayProvider(userId));
              // ref.invalidate(getTotalSchedulesTomorrowProvider(userId));
              // ref.invalidate(employeeSchedulesVmProvider(userId, dateSelected));   
            
            } 
          }
      
        }).catchError((error){
            showExceptionDialog(context, content: 'Ocorreu um erro ao excluir o agendamento.');
        },);
    }

    return Container(
      width: 260, //MediaQuery.of(context).size.width*0.5,
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.colorGreen, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Container(
                    //   width: 40,
                    //   height: 40,
                    //   decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       image: switch (widget.employee.avatar) {
                    //         final avatar ? => NetworkImage(avatar),
                    //         _ => const AssetImage(AppImages.avatarImage),
                    //       } as ImageProvider,
                    //     )
                    //   ),
                    // ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    Expanded(
                      child: Text(
                        widget.employee.name,
                        overflow: TextOverflow.ellipsis,
                        //maxLines: 2,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    PopupMenuButton<SampleItem>(
                      color: Colors.white,
                      enableFeedback: true,
                      surfaceTintColor: Colors.white,
                      padding: EdgeInsets.zero,
                      position: PopupMenuPosition.under,
                      icon: const Icon(Icons.more_vert, color: AppColors.colorGreen),
                      //initialValue: selectedMenu,

                      // // Callback that sets the selected popup menu item.
                      // onSelected: (SampleItem item) {
                      //   setState(() {
                      //     selectedMenu = item;
                          
                      //   });
                      // },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                        PopupMenuItem<SampleItem>(
                          value: SampleItem.itemOne,
                          child: ListTile(
                            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            onTap: () async{
                              Navigator.of(context).pop();
                              await Navigator.of(context).pushNamed('/employeeProfile', arguments: widget.employee);
                              //;
                            },
                             leading: const Icon(
                              Icons.person_2_outlined,
                              size: 24,
                              color: AppColors.colorGreen,
                            ),
                            title: const Text(
                              'Ver Perfil',
                              style: TextStyle(color: AppColors.colorGreen, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        PopupMenuItem<SampleItem>(
                          value: SampleItem.itemTwo,
                          child: ListTile(
                            onTap: () async{
                              Navigator.of(context).pop();
                              await Navigator.of(context).pushNamed(
                                '/employee/updateEmployee', 
                                arguments: widget.employee // widget.test 
                              );
                              ref.invalidate(getMeProvider);  
                              // ref.invalidate(homeAdmVmProvider);
                              ref.invalidate(getAdmPlaceProvider);
                            },
                             leading: const Icon(
                              AppIcons.editIcon,
                              size: 18,
                              color: AppColors.colorGreen,
                            ),
                            title: const Text(
                              'Editar horários',
                              //'Editar Colaborador',
                              style: TextStyle(color: AppColors.colorGreen, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      
                        PopupMenuItem<SampleItem>(
                          value: SampleItem.itemThree,
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              deleteUser(widget.employee.id, widget.employee);
                              //deleteUserSelected(widget.employee.id);
                            },
                            leading: const Icon(
                              AppIcons.trashIcon,
                              size: 18,
                              color: AppColors.colorRed,
                            ),
                            title: const Text(
                              'Excluir Colaborador',
                              style: TextStyle(color: AppColors.colorRed, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //  Expanded(
                //    child: Text(
                //      employee.name,
                //      //maxLines: 2,
                //      softWrap: true,
                //      style: const TextStyle(
                //        fontSize: 18,
                //        fontWeight: FontWeight.w500,
                //      ),
                //    ),
                //  ),
                // const SizedBox(
                //    height: 25,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10)
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/schedule', arguments: widget.employee);
                      },
                      child: const Text('Fazer Agendamento'),
                    ),
                    const SizedBox(
                       width: 15,
                    ),
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30)
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/employee/schedulesEmployee', arguments: widget.employee);
                        //context.pushNamed('/employee/schedule', arguments: employee);
                      },
                      child: const Text('Ver Agenda'),
                    ),
                  
                    // const Icon(
                    //   AppIcons.trashIcon,
                    //   size: 25,
                    //   color: AppColors.colorRed,
                    // ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
