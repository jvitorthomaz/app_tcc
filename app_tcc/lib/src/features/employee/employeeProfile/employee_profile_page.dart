import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:tcc_app/src/models/users_model.dart';

class EmployeeProfilePage extends ConsumerWidget {

  const EmployeeProfilePage({ super.key });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    final myInfo = ref.watch(getMeProvider);
    final placeAsyncValue = ref.watch(getAdmPlaceProvider);

    final userData = switch (userModel) {
      AdmUserModel(:final workDays, :final workHours) => (
        workDays: workDays!,
        workHours: workHours!,
      ),

      EmployeeUserModel(:final workDays, :final workHours) => (
        workDays: workDays,
        workHours: workHours,
      ),

    };


    return Scaffold(
      appBar: AppBar(title: const Text('Perfil de colaborador'),),
      
      body: 

      // placeAsyncValue.when(
      //   error: (error, stackTrace) {
      //     log(
      //       'Erro ao carregar a página',
      //       error: error, 
      //       stackTrace: stackTrace
      //     );
      //     return const Center(
      //       child: Column(
      //         children: [
      //           Icon(Icons.info_outline, size: 50,),
      //           Text('Erro ao carregar a página'),
      //         ],
      //       ),
      //     );
      //   }, 
      //   loading: () => const AppLoader(),
      //   data: (placeModel){
      //     final PlaceModel(:openingDays, :openingHours) = placeModel;
      //     return 
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Container(
                      // width: 350, 
                      // height: 200,
                      
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(

                       
                        
                        //borderRadius: BorderRadius.circular(10),
                        //border: Border.all(color: AppColors.colorGreen, width: 2),
                      ),
                      child: FutureBuilder(
                        future: FirebaseStorage.instance
                            .ref("${userModel.firebaseUUID}/${userModel.profileFileName}.png")
                            .getDownloadURL(),
                        builder: (context, snapshot) {
                          
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator()
                            );
                          } else if(snapshot.data == null){
                            return const CircleAvatar(
                              radius: 64,
                              child: Icon(
                                Icons.person, 
                                size: 50,
                                color: AppColors.colorGreen,
                              ),
                            );
                            // return const CircleAvatar(
                            //   radius: 15,
                            //   backgroundColor: Colors.white,
                            //   child: Icon(
                            //     Icons.person_2_outlined, 
                            //     size: 25, 
                            //     color: AppColors.colorGreen,
                            //   ),
                            // );
                          }
                          else{
                            //return Image.network(snapshot.data!);
                            return CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(snapshot.data!),
                            );
                          }
                        },
                      ),
                    ),

                    const Divider(thickness: 2,),


                    Container(
                      width: 350, 
                      height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        //borderRadius: BorderRadius.circular(10),
                        //border: Border.all(color: AppColors.colorGreen, width: 2),
                      ),


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
                              userModel.name,
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
                      decoration: const BoxDecoration(
                        //borderRadius: BorderRadius.circular(10),
                        //border: Border.all(color: AppColors.colorGreen, width: 2),
                      ),


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'E-mail:',
                            style: TextStyle(
                              color: AppColors.colorGreen,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              userModel.email,
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
                      decoration: const BoxDecoration(
                        //borderRadius: BorderRadius.circular(10),
                        //border: Border.all(color: AppColors.colorGreen, width: 2),
                      ),


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Meus dias de trabalho:',
                            style:  TextStyle(
                              color: AppColors.colorGreen,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          ListView.builder(
                            itemCount: userData.workDays.length,
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
                                    //Text(userData.workDays[index]),
                                    Text(
                                      userData.workDays[index] == 'Seg'? 'Segunda':
                                      userData.workDays[index] == 'Ter'? 'Terça':
                                      userData.workDays[index] == 'Qua'? 'Quarta':
                                      userData.workDays[index] == 'Qui'? 'Quinta':
                                      userData.workDays[index] == 'Sex'? 'Sexta':
                                      userData.workDays[index] == 'Sab'? 'Sábado':
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
                      //height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        //borderRadius: BorderRadius.circular(10),
                        //border: Border.all(color: AppColors.colorGreen, width: 2),
                      ),


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Meus horários de trabalho:',
                            style:  TextStyle(
                              color: AppColors.colorGreen,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                           ListView.builder(
                            itemCount: userData.workHours.length,
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
                                    Text('${userData.workHours[index]}:00'),
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

      //   }
      // )
    );
  }
}
