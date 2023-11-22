import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_state.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_vm.dart';
import 'package:tcc_app/src/features/home/home_adm/widgets/home_list_employee_tile.dart';
import 'package:tcc_app/src/features/home/widgets/home_header.dart';

// TODO - padding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
class HomeAdmPage extends ConsumerWidget {

  const HomeAdmPage({ super.key });

   @override
   Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdmVmProvider);


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppColors.colorGreen,
          onPressed: () async {
            await Navigator.of(context).pushNamed('/employee/registerEmployee');
            ref.invalidate(getMeProvider);  
            ref.invalidate(homeAdmVmProvider);
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
        // body: CustomScrollView(
        //   slivers: [
        //     SliverToBoxAdapter(
        //       child: HomeHeader(),
        //     ),
        //     SliverList(
        //       delegate: SliverChildBuilderDelegate(
        //         (context, index) => HomeListEmployeeTile(),
        //         childCount: 20
        //       )
        //     )
            
        //   ],
        // )
        body: homeState.when(
          data: (HomeAdmState data) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 65),
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: HomeHeader(),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => HomeListEmployeeTile(
                        employee: data.employees[index],
                        //test:  data.modelEmployees[index],
                      ),
                      childCount: data.employees.length,
                    )
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            log(
              'Erro ao carregar colaboradores',
              error: error, 
              stackTrace: stackTrace
            );
            
            return const Center(
              child: Text('Erro ao carregar pagina '),
            );
          },
          loading: () {
            return const AppLoader();
          },
        ),
      //   bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         AppIcons.addNewEmplyeeeIcon,
      //         color: AppColors.colorGreen,
      //       ),
      //       label: 'Adicionar Colaborador',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         AppIcons.addNewEmplyeeeIcon,
      //         color: AppColors.colorGreen,
      //       ),
      //       label: 'Adicionar Colaborador',
      //     ),
         
      //   ],
      //   // currentIndex: _selectedIndex,
      //   // selectedItemColor: Colors.red[800],
      //   // onTap: _onItemTapped,
      // ),
      ),
      
    );
  }
}
