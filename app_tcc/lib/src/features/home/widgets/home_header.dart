import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';

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
    //final clinic = ref.watch();

    return Container(
      padding: const EdgeInsets.fromLTRB(26, 50, 26, 20),
      margin: const EdgeInsets.only(bottom: 20),
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
          // clinic.maybeWhen(
          //   data: (clinicData) {
              //return 
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xffbdbdbd),
                    child: SizedBox.shrink(),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Flexible(
                    child: Text(
                      'Nome Adm Clinica',
                      //clinicData.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  const Expanded(
                    child: Text(
                      'editar',
                      style: TextStyle(
                        color: Colors.white,
                        //color: AppColors.colorGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //ref.read(.notifier).logout();
                    },
                    icon: const Icon(
                      AppIcons.exitAppIcon,
                      color: AppColors.colorGreen,
                      size: 32,
                    ),
                  )
                ],
              ),
          //   },
          //   orElse: () {
          //     return const Center(
          //       //child: AppLoader(),
          //     );
          //   },
          // ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Bem Vindo',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Faça um Agendamento',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          Offstage(
            offstage: !showFilter,
            child: const SizedBox(
              height: 20,
            ),
          ),
          Offstage(
            offstage: !showFilter,
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text('Buscar Colaborador'),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(
                    AppIcons.searchIcon,
                    color: AppColors.colorGreen,
                    size: 26,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}