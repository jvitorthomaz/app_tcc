
import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/app_icons.dart';
import 'package:tcc_app/src/core/ui/constants.dart';

class UserAvatarWidget extends StatelessWidget{
  final bool hideUploadButton;

  const UserAvatarWidget({super.key}) : hideUploadButton = false;
  const UserAvatarWidget.withoutButton({super.key}) : hideUploadButton = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.avatarImage),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Offstage(
              offstage: hideUploadButton,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                    Border.all(
                      color: AppColors.colorGreen,
                      width: 3
                    ),
                  shape: BoxShape.circle
                ),
                child: const Icon(
                  AppIcons.addNewEmplyeeeIcon,
                  color: AppColors.colorGreen,
                  size: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}  
