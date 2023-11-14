import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/providers/aplication_providers.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_vm.dart';

class HomeHeader extends ConsumerWidget {
  final bool showFilter;

  const HomeHeader({
    super.key
  }) : showFilter = true;

  const HomeHeader.withoutFilter({
    super.key
  }) : showFilter = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clinicInfo = ref.watch(getAdmPlaceProvider);
    final myInfo = ref.watch(getMeProvider);

    return Container(
      padding: const EdgeInsets.fromLTRB(26, 50, 26, 20),
      //margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        //color: Colors.white,
        color: AppColors.colorGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        // image: DecorationImage(
        //   image: AssetImage(
        //     AppImages.imgLogo,
        //   ),
        //   fit: BoxFit.cover,
        //   opacity: 0.5,
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //      IconButton(
          //           onPressed: () {
          //             ref.read(homeAdmVmProvider.notifier).logout();
          //           },
          //           icon: const Icon(
          //             AppIcons.exitAppIcon,
          //             color: Colors.white,
          //             size: 25,
          //           ),
          //         )

          //   ],
          // ),
          //Deixa opcional os atributos
          clinicInfo.maybeWhen(
            data: (clinicInfoData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const CircleAvatar(
                  //   backgroundColor: Color(0xffbdbdbd),
                  //   child: SizedBox.shrink(),
                  // ),
                  // const Siz  edBox(
                  //   width: 18,
                  // ),
                  Flexible(
                    child: Text(
                      clinicInfoData.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 18,
                  // ),
                  // const Expanded(
                  //   child: Text(
                  //     'editar',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       //color: AppColors.colorGreen,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
                  
                  // const SizedBox(
                  //   width: 120,
                  // ),
                  IconButton(
                    onPressed: () {
                      ref.read(homeAdmVmProvider.notifier).logout();
                    },
                    icon: const Icon(
                      AppIcons.exitAppIcon,
                      color: Colors.white,
                      size: 32,
                    ),
                  )
                ],
              );
            },
            
            orElse: () {
              return const Center(
                child: AppLoader(),
              );
            },
          ),
          const SizedBox(
            height: 5,
          ),
           const Text(
            'Olá!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          const Text(
            'Faça um Agendamento',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          Offstage(
            offstage: !showFilter,
            child: const SizedBox(
              height: 20,
            ),
          ),
          // Offstage(
          //   offstage: !showFilter,
          //   child: TextField(
          //     decoration: const InputDecoration(
          //       label: Text('Buscar Colaborador'),
          //       suffixIcon: Padding(
          //         padding: EdgeInsets.only(right: 20.0),
          //         child: Icon(
          //           AppIcons.searchIcon,
          //           color: AppColors.colorGreen,
          //           size: 26,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}