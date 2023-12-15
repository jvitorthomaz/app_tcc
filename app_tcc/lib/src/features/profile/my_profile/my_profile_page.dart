import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/models/place_model.dart';
import 'package:tcc_app/src/models/users_model.dart';

class MyProfilePage extends ConsumerStatefulWidget {

  const MyProfilePage({ super.key });

  @override
  ConsumerState<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends ConsumerState<MyProfilePage> {

  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    final myInfo = ref.watch(getMeProvider);
    final placeAsyncValue = ref.watch(getAdmPlaceProvider);
    //  final user = FirebaseAuth.instance.currentUser;

    final userData = switch (userModel) {
      AdmUserModel(:final workDays, :final workHours) => (
        workDays: workDays != null ? workDays :  [],
        workHours: workHours != null ? workHours :  [],
        // workDays: workDays!,
        // workHours: workHours!,
      ),

      EmployeeUserModel(:final workDays, :final workHours) => (
        workDays: workDays,
        workHours: workHours,
      ),

    };

    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu perfil'),
        actions: [
          // IconButton(
          //   onPressed: () async{
          //     await Navigator.of(context).pushNamed('/updateProfile', arguments: userModel);

          //   }, 
          //   icon: const Icon(
          //     // Icons.work_outline,
          //     Icons.edit,
          //     color: Colors.green,
          //   ),
          // )

        ],
      ),
      
      body: 

      placeAsyncValue.when(
        error: (error, stackTrace) {
          log(
            'Erro ao carregar a página',
            error: error, 
            stackTrace: stackTrace
          );
          // return const Center(
          //   child: Column(
          //     children: [
          //       Icon(Icons.info_outline, size: 50,),
          //       Text('Erro ao carregar a página'),
          //     ],
          //   ),
          // );
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Container(
                      width: 350, 
                      height: 200,
                      
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(10),
                        //border: Border.all(color: AppColors.colorGreen, width: 2),
                      ),
                      child: 
                          (FirebaseAuth.instance.currentUser!.photoURL != null) ? 
                          ClipRRect(
                              borderRadius: BorderRadius.circular(64),
                              child: Image.network(
                                FirebaseAuth.instance.currentUser!.photoURL!,
                                width: 128,
                                height: 128,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const CircleAvatar(
                              radius: 64,
                              child: Icon(
                                Icons.person, 
                                size: 50,
                                color: AppColors.colorGreen,
                              ),
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
                  ]
                )
              )
            )
          );
        }, 
        loading: () => const AppLoader(),
        data: (placeModel){
          final PlaceModel(:openingDays, :openingHours) = placeModel;
          return 
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
                      child: SizedBox(
                        child: 
                        (FirebaseAuth.instance.currentUser!.photoURL != null) ? 
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(
                              FirebaseAuth.instance.currentUser!.photoURL!,
                              
                            )
                               
                          )
                          : const CircleAvatar(
                              radius: 64,
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: AppColors.colorGreen,
                              ),
                            ),
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
          );

        }
      )
    );
  }
}
