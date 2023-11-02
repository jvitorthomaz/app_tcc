import 'package:flutter/material.dart';

// fu-class-singleton

class AppNavGlobalKey {
  static AppNavGlobalKey? _instance;
  final navKey = GlobalKey<NavigatorState>();
 
  // Avoid self instance
  AppNavGlobalKey._();
  static AppNavGlobalKey get instance => _instance ??= AppNavGlobalKey._();

}
