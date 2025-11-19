
import 'package:app_e_commerce/modules/splash/view_models/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});
  var viewModel = Get.put(SplashViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return  Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                textAlign: TextAlign.center,
                "${viewModel.splashModel.value.title}",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                textAlign: TextAlign.center,
                "${viewModel.splashModel.value.subTitle}",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              color: Colors.blue,
            )
          ],
        ),

      );
    });
  }
}
