import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/features/employee/mySchedules/employee_schedules_vm.dart';
import 'package:tcc_app/src/features/history/schedules_history_list_tile.dart';
import 'package:tcc_app/src/features/history/user_schedules_history_vm.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_vm.dart';
import 'package:tcc_app/src/models/users_model.dart';

class UserSchedulesHistory extends ConsumerStatefulWidget {

  const UserSchedulesHistory({ super.key });

  @override
  ConsumerState<UserSchedulesHistory> createState() => _UserSchedulesHistoryState();
}

class _UserSchedulesHistoryState extends ConsumerState<UserSchedulesHistory> {
    late DateTime dateSelected;

  @override
  void initState() {
    super.initState();
    final DateTime(:year, :month, :day) = DateTime.now();
    dateSelected = DateTime(year, month, day, 0, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    final userId = userModel.id;
    final homeState = ref.watch(homeAdmVmProvider);
    final clinicInfo = ref.watch(getAdmPlaceProvider);
    final myInfo = ref.watch(getMeProvider);


    final scheduleAsync = ref.watch(
      userSchedulesHistoryVmProvider(userId)
    );


    return Scaffold(
      appBar: AppBar(title: const Text('Meu histórico de agendamentos'),),
      backgroundColor: Colors.white,
      body: scheduleAsync.when(
        data: (historyData) {

          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: 
            (historyData.isEmpty)
            ? const Center(
                child: Column(
                  children: [
                    Icon(Icons.sentiment_dissatisfied, size: 100,),
                    Text(
                      "Você ainda não possui agendamentos cadastrados",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              )
            : 

            CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => 
                      SchedulesHistoryListTile(
                        schedules: historyData.reversed.toList()[index], 
                        userId: userId, //.employees[index],
                        
                      ),
                      childCount: historyData.length,
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
    );
  }
}
