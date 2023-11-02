import 'package:flutter/material.dart';

sealed class AppColors {
  static const colorBrown = Color(0xFFB07B01);
  static const colorGrey = Color(0xFF999999);
  static const colorGreyx = Color(0xFFE6E2E9);
  static const colorGreyLight = Color(0xFFB07B01);
  static const colorBlue = Colors.blue;
  static const colorGreen = Colors.green;
  static const colorGreenLight = Colors.lightGreen;

  static const colorRed = Color(0xFFEB1212);
  static const colorBlack = Colors.black;
   static const colorWhite = Colors.white;

}

sealed class AppFonts {
  static const fontPopins = 'Poppins';
}

sealed class AppImages {
  static const backgroundImage = 'assets/images/background_image_chair.jpg';
  static const imgLogo = 'assets/images/img_logo.png';
  //static const imgLogo = 'assets/images/imgLogo.png';
  static const avatarImage = 'assets/images/avatar.png';
}
