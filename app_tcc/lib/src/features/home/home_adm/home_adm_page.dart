import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/features/home/home_adm/widgets/home_list_employee_tile.dart';
import 'package:tcc_app/src/features/home/widgets/home_header.dart';

class HomeAdmPage extends StatefulWidget {

  const HomeAdmPage({ super.key });

  @override
  State<HomeAdmPage> createState() => _HomeAdmPageState();
}

class _HomeAdmPageState extends State<HomeAdmPage> {

   @override
   Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppColors.colorGreen,
          onPressed: () async {
            // await context.pushNamed('/employee/register');
            // ref.invalidate(getMeProvider);  
            // ref.invalidate(homeAdmVmProvider);
          },
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 16,
            child: Icon(
              AppIcons.addNewEmplyeeeIcon,
              color: AppColors.colorGreen,
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: HomeHeader(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => HomeListEmployeeTile(),
                childCount: 20
              )
            )
            
          ],
        )
        // body: homeState.when(
        //   data: (HomeAdmState data) {
        //     return 
        //     CustomScrollView(
        //       slivers: [
        //         const SliverToBoxAdapter(
        //           child: HomeHeader(),
        //         ),
        //         SliverList(
        //           delegate: SliverChildBuilderDelegate(
        //             (context, index) => HomeListEmployeeTile(employee: data.employees[index]),
        //             childCount: data.employees.length,
        //           )
        //         ),
        //       ],
        //     );
        //   },
        //   error: (error, stackTrace) {
        //     log('Erro ao carregar colaboradores',
        //         error: error, stackTrace: stackTrace);
        //     return const Center(
        //       child: Text('Erro ao carregar pagina '),
        //     );
        //   },
        //   loading: () {
        //     return const AppLoader();
        //   },
        // ),
      ),
    );
  }
}