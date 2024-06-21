import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/features/drawers/drawer_adm.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_state.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_vm.dart';
import 'package:tcc_app/src/features/home/home_adm/widgets/home_list_employee_tile.dart';
import 'package:tcc_app/src/features/home/widgets/home_header.dart';

class HomeAdmPage extends ConsumerWidget {

  const HomeAdmPage({ super.key });

   @override
   Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdmVmProvider);
    final clinicInfo = ref.watch(getAdmPlaceProvider);
    final myInfo = ref.watch(getMeProvider);


    return SafeArea(
      child: Scaffold(
        drawer: DrawerAdm(),
        appBar: AppBar(
          title: const Text('Área de Trabalho', 
            style: TextStyle(color: Colors.white),
          ), 
          backgroundColor: AppColors.colorGreen,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(homeAdmVmProvider.notifier).logout();
              },
              icon: const Icon(
                AppIcons.exitAppIcon,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,

        body: homeState.when(
          data: (HomeAdmState data) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: RefreshIndicator(
                onRefresh: () async{
                  Navigator.of(context).pushNamed('/home/admUser');
                  

                },
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: HomeHeader(),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => HomeListEmployeeTile(
                          employee: data.employees[index],
                        ),
                        childCount: data.employees.length,
                      )
                    ),
                  ],
                ),
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
      ),
      
    );
  }
}
