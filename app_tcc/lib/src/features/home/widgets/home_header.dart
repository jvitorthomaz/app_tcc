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
      padding: const EdgeInsets.fromLTRB(26, 0, 26, 20),
      //margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        //color: Colors.white,
        color: AppColors.colorGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Deixar opcional os atributos
          clinicInfo.maybeWhen(
            data: (clinicInfoData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
          myInfo.maybeWhen(
            data: (myInfoData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Text(
                      'Olá, ${myInfoData.name}!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      'Faça um Agendamento',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Offstage(
                      offstage: !showFilter,
                      child: const SizedBox(
                        height: 20,
                      ),
                    ),
                ],

              );
            }, 
            orElse: () {
              return const Center(
                child: AppLoader(),
              );
            }
          )
        ],
      ),
    );
  }
}
