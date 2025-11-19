
import 'package:app_e_commerce/modules/home/view/home_view.dart';
import 'package:app_e_commerce/modules/login/view/login_view.dart';
import 'package:app_e_commerce/modules/splash/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class MyApp  extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF03A9F4), // Light Blue
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF03A9F4), // Light Blue
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(
            name: '/splash',
            page: ()=> SplashView(),
            transition: Transition.fadeIn
        ),
        GetPage(
            name: '/',
            page: ()=> HomeView(),
            transition: Transition.fadeIn
        ),
        GetPage(
            name: '/login',
            page: ()=> LoginView(),
            transition: Transition.fadeIn
        ),
      ],
    );
  }
}
