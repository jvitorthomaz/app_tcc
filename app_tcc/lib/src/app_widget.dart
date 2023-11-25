import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tcc_app/src/core/ui/app_nav_global_key.dart';
import 'package:tcc_app/src/core/ui/app_theme.dart';
import 'package:tcc_app/src/core/ui/widgets/app_loader.dart';
import 'package:tcc_app/src/features/auth/login/login_page.dart';
import 'package:tcc_app/src/features/auth/register/register_clinic/place_register_page.dart';
import 'package:tcc_app/src/features/auth/register/register_user/user_register_page.dart';
import 'package:tcc_app/src/features/clinic/user_clinic/user_clinic_profile.dart';
import 'package:tcc_app/src/features/employee/mySchedules/employee_schedules_page.dart';
import 'package:tcc_app/src/features/employee/register/employee_register_page.dart';
import 'package:tcc_app/src/features/employee/updateEmployee/employee_update_page.dart';
import 'package:tcc_app/src/features/employee/updateSchedule/update_schedule_page.dart';
import 'package:tcc_app/src/features/home/home_adm/home_adm_page.dart';
import 'package:tcc_app/src/features/home/home_employee/home_employee_page.dart';
import 'package:tcc_app/src/features/profile/my_profile/my_profile_page.dart';
import 'package:tcc_app/src/features/profile/update_password/user_update_password_page.dart';
import 'package:tcc_app/src/features/profile/update_profile/profile_update_page.dart';
import 'package:tcc_app/src/features/schedules/schedules_page.dart';
import 'package:tcc_app/src/features/splash/splash_page.dart';

class AppWidget extends StatelessWidget {

  const AppWidget({ super.key });

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const AppLoader(),
      builder: (AsyncNavigatorObserver){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'App',
          theme: AppTheme.themeData,

          navigatorObservers: [AsyncNavigatorObserver],
          navigatorKey: AppNavGlobalKey.instance.navKey,

          routes: {
            '/':(_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/auth/register/user': (_) => const UserRegisterPage(),
            '/auth/register/place': (_) => const PlaceRegisterPage(),
            '/home/admUser': (_) => const HomeAdmPage(),
            '/home/employeeUser': (_) => const HomeEmployeePage(),
            '/employee/registerEmployee':(_) => const EmployeeRegisterPage(),
            '/employee/schedulesEmployee':(_) => const EmployeeSchedulesPage(),
            '/employee/updateEmployee': (_) => const EmployeeUpdatePage(),
            '/schedule': (_) => const SchedulesPage(),
            '/employee/updateSchedule': (_) => const UpdateSchedulesPage(),
            '/myProfile': (_) => const MyProfilePage(),
            '/profileEmployee': (_) => const Center(child: Text('tela de perfil Adm')),
            '/updatePassword': (_) => const UserUpdatePasswordPage(),
            '/updateProfile': (_) => const ProfileUpdatePage(),
            '/userClinicProfile': (_) => const UserClinicProfilePage(),
            
          },
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale('pt', 'BR'),
          supportedLocales: const [Locale('pt', 'BR')],
        );
      }
    );
  }
}
