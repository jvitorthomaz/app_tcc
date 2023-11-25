import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    return Scaffold(
      appBar: AppBar(title: const Text('Minha Clínica'),),
      
      body: 

      placeAsyncValue.when(
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
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   //Container(
                    //   width: 350, 
                    //   height: 200,
                      
                    //   margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    //   padding: const EdgeInsets.all(10),
                    //   decoration: BoxDecoration(

                       
                        
                    //     //borderRadius: BorderRadius.circular(10),
                    //     //border: Border.all(color: AppColors.colorGreen, width: 2),
                    //   ),
                    //   child: Text('Foto'),
                    // ),
                    Divider(thickness: 1, color: AppColors.colorGreen,),
                    // Divider(thickness: 2,),
                    Container(
                      width: 350, 
                      height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(10),
                        //border: Border.all(color: AppColors.colorGreen, width: 2),
                      ),


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nome:',
                            style: const TextStyle(
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

                    Divider(thickness: 2,color: AppColors.colorGreen,),
                    // Divider(thickness: 2,),


                    Container(
                      width: 350, 
                      height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(10),
                        //border: Border.all(color: AppColors.colorGreen, width: 2),
                      ),


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'E-mail:',
                            style: const TextStyle(
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

                    Divider(thickness: 2,color: AppColors.colorGreen,),
                    // Divider(thickness: 2,),

                    Container(
                      width: 350, 
                      //  height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(10),
                        //border: Border.all(color: AppColors.colorGreen, width: 2),
                      ),


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dias que a clínica abre:',
                            style: const TextStyle(
                              color: AppColors.colorGreen,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          ListView.builder(
                            itemCount: placeModel.openingDays.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context,int index){
                              print(index);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.fiber_manual_record, size: 5),
                                    const SizedBox(
                                        width: 1,
                                    ),
                                    //Text(placeModel.openingDays[index]),
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

                    Divider(thickness: 2,color: AppColors.colorGreen,),
                    // Divider(thickness: 2,),


                    Container(
                      width: 350, 
                      //height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(10),
                        //border: Border.all(color: AppColors.colorGreen, width: 2),
                      ),


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Horários que a clínica abre:',
                            style: const TextStyle(
                              color: AppColors.colorGreen,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                           ListView.builder(
                            itemCount: placeModel.openingHours.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context,int index){
                              print(index);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.fiber_manual_record, size: 5),
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
          );
        }
      )
    );
  }
}
