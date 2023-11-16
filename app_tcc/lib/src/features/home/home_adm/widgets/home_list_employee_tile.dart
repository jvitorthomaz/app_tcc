import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/models/users_model.dart';

enum SampleItem {itemOne, itemTwo, itemThree,}


class HomeListEmployeeTile extends StatelessWidget {

  final UserModel employee;

  const HomeListEmployeeTile({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
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
          // Container(
          //   width: 50,
          //   height: 60,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: switch (employee.avatar) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        employee.name,
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
                            onTap: () {
                              //trocarCondominio();
                            },
                             leading: const Icon(
                              AppIcons.editIcon,
                              size: 18,
                              color: AppColors.colorGreen,
                            ),
                            title: const Text(
                              'Editar Colaborador',
                              //textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.colorGreen, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      
                        PopupMenuItem<SampleItem>(
                          value: SampleItem.itemTwo,
                          child: ListTile(
                            onTap: () {
                              //trocarCondominio();
                            },
                            leading: const Icon(
                              AppIcons.trashIcon,
                              size: 18,
                              color: AppColors.colorRed,
                            ),
                            title: const Text(
                              'Excluir Colaborador',
                              //textAlign: TextAlign.center,
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
                        Navigator.of(context).pushNamed('/schedule', arguments: employee);
                      },
                      child: const Text('Fazer Agendamento', 
                        //style: TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                       width: 15,
                    ),
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30)
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/employee/schedulesEmployee', arguments: employee);
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