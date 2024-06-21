import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/constants/globalConst.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:tcc_app/src/models/users_model.dart';

class UserClinicProfilePage extends ConsumerWidget {

  const UserClinicProfilePage({ super.key });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myInfo = ref.watch(getMeProvider);
    final placeAsyncValue = ref.watch(getAdmPlaceProvider);
    return placeAsyncValue.when(
        error: (error, stackTrace) {
          log(
            'Erro ao carregar a página',
            error: error, 
            stackTrace: stackTrace
          );
          return const Center(
            child: Column(
              children: [
                Icon(Icons.info_outline, size: 50,),
                Text('Erro ao carregar a página'),
              ],
            ),
          );
        }, 
        loading: () => const AppLoader(),
        data: (placeModel){
          final PlaceModel() = placeModel;
          return  Scaffold(
            appBar: AppBar(
              title: const Text('Minha Clínica'),
              actions: [
                Offstage(
                  offstage: !GlobalConst.isADM,
                  child: IconButton(
                    onPressed: () async{
                      await Navigator.of(context).pushNamed('/updateClinic', arguments: placeModel);

                    }, 
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  )

                )
              ],
            ),
            
            body: Padding(
              padding: const EdgeInsets.all(0.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 350, 
                        height: 80,
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding: const EdgeInsets.all(10),
                     
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nome:',
                              style: TextStyle(
                                color: AppColors.colorGreen,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                placeModel.name,
                                overflow: TextOverflow.ellipsis,
                                //maxLines: 2,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      
                      ),

                      const Divider(thickness: 2,),


                      Container(
                        width: 350, 
                        height: 80,
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'E-mail:',
                              style:  TextStyle(
                                color: AppColors.colorGreen,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                placeModel.email,
                                overflow: TextOverflow.ellipsis,
                                //maxLines: 2,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      
                      ),

                      const Divider(thickness: 2,),

                      Container(
                        width: 350, 
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Dias que a clínica abre:',
                              style: TextStyle(
                                color: AppColors.colorGreen,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            ListView.builder(
                              itemCount: placeModel.openingDays.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context,int index){
                                print(index);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.fiber_manual_record, size: 5),
                                      const SizedBox(
                                          width: 1,
                                      ),
                                      Text(
                                        placeModel.openingDays[index] == 'Seg'? 'Segunda':
                                        placeModel.openingDays[index] == 'Ter'? 'Terça':
                                        placeModel.openingDays[index] == 'Qua'? 'Quarta':
                                        placeModel.openingDays[index] == 'Qui'? 'Quinta':
                                        placeModel.openingDays[index] == 'Sex'? 'Sexta':
                                        placeModel.openingDays[index] == 'Sab'? 'Sábado':
                                        'Domingo'
                                      ),

                                    ],
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                      
                      ),

                      const Divider(thickness: 2,),


                      Container(
                        width: 350, 
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding: const EdgeInsets.all(10),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Horários que a clínica abre:',
                              style: TextStyle(
                                color: AppColors.colorGreen,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            ListView.builder(
                              itemCount: placeModel.openingHours.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context,int index){
                                print(index);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.fiber_manual_record, size: 5),
                                      const SizedBox(
                                          width: 1,
                                        ),
                                      Text('${placeModel.openingHours[index]}:00'),
                                    ],
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                      
                      ),
                    ],
                  ),
                ),
              ),
            )
          );
        }
    );
  }
}
