import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/features/drawers/drawer_employee.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/core/ui/widgets/user_avatar_widget.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_vm.dart';
import 'package:tcc_app/src/features/home/home_employee/home_employee_provider.dart';
import 'package:tcc_app/src/features/home/widgets/home_header.dart';
import 'package:tcc_app/src/models/users_model.dart';

class HomeEmployeePage extends ConsumerWidget {
  const HomeEmployeePage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModelAsync = ref.watch(getMeProvider);
    

    return Scaffold(
      drawer: DrawerEmployee(),
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
      body: userModelAsync.when(
        error: (e, s) {
          const errorMessage = 'Erro ao carregar página';
          log(errorMessage, error: e, stackTrace: s);
          return const Center(
            child: Text(errorMessage),
          );
        },
        loading: () => const AppLoader(),
        data: (user) {
          final UserModel(:id, :name) = user;

          return RefreshIndicator(
            onRefresh: () async{
              Navigator.of(context).pushNamed('/home/employeeUser');
            },
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: HomeHeader(),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 24,
                            color: AppColors.colorGreen,
                            fontWeight: FontWeight.w500,
          
                          ),
                        ),
                        
                        const SizedBox(height: 35),
                        
                        const Text(
                          'Seus agendamentos:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
          
                        const SizedBox(height: 5),
          
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.colorGreen),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer(
                                builder: (context, ref, child) {
                                  
                                  final totalAsync = ref.watch(
                                    getTotalSchedulesTodayProvider(id)
                                  );
          
                                  return totalAsync.when(
                                    error: (e, s) {
                                      const errorMessage = 'Erro ao carregar total de agendamentos';
                                      return const Text(errorMessage);
                                    },
                                    loading: () => const AppLoader(),
                                    skipLoadingOnRefresh: false,
                                    data: (totalSchedulesToday) {
                                      return Text(
                                        '$totalSchedulesToday',
                                        style: const TextStyle(
                                          fontSize: 40,
                                          color: AppColors.colorGreen,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              const Text(
                                'Hoje',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.colorGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
          
                        const SizedBox(
                           height: 5,
                        ),
          
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.colorGreen),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer(
                                builder: (context, ref, child) {
                                  final totalAsync = ref.watch(
                                    getTotalSchedulesTomorrowProvider(id)
                                  );
          
                                  return totalAsync.when(
                                    error: (e, s) {
                                      const errorMessage = 'Erro ao carregar total de agendamentos';
                                      return const Text(errorMessage);
                                    },
                                    loading: () => const AppLoader(),
                                    skipLoadingOnRefresh: false,
                                    data: (totalSchedulesTomorrow) {
                                      return Text(
                                        '$totalSchedulesTomorrow',
                                        style: const TextStyle(
                                          fontSize: 40,
                                          color: AppColors.colorGreen,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              const Text(
                                'Amanhã',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.colorGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
          
                        const SizedBox(height: 50),
          
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await Navigator.of(context).pushNamed(
                                    '/schedule',
                                    arguments: user,
                                  );
                                  ref.invalidate(getTotalSchedulesTodayProvider(id));
                                  ref.invalidate(getTotalSchedulesTomorrowProvider(id));
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(55),
                                ),
                                child: const Text('AGENDAR CLIENTE'),
                              ),
                                const SizedBox(height: 25),
                                OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(55),
                                  ),
          
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      '/employee/schedulesEmployee',
                                      arguments: user,
                                    );
                                  },
                                  child: const Text('VER AGENDA'),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
