import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/models/users_model.dart';

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
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.colorGreen),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Row(
                   children: [
                    Expanded(
                      child: Text(
                        employee.name,
                        //maxLines: 2,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                       width: 10,
                    ),
                     const Icon(
                      AppIcons.editIcon,
                      size: 15,
                      color: AppColors.colorGreen,
                    ),
                   ],
                 ),
                const SizedBox(
                   height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10)
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/schedule', arguments: employee);
                      },
                      child: Text('Fazer Agendamento', 
                        //style: TextStyle(fontSize: 12),
                      ),
                    ),
                    // const SizedBox(
                    //    width: 5,
                    // ),
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 15)
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/employee/schedulesEmployee', arguments: employee);
                        //context.pushNamed('/employee/schedule', arguments: employee);
                      },
                      child: const Text('Ver Agenda'),
                    ),
                  
                    const Icon(
                      AppIcons.trashIcon,
                      size: 25,
                      color: AppColors.colorRed,
                    ),
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