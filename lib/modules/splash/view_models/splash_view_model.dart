
import 'package:get/get.dart';

import '../model/splash_model.dart';

class SplashViewModel extends GetxController{
  var splashModel = SplashModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setValueTitle();
    timerToHome();
  }

  timerToHome() async{
    await Future.delayed(Duration(seconds: 3));
    Get.offAllNamed("/");
  }


  setValueTitle(){
    splashModel.value.title = "Welcome to ";
    splashModel.value.subTitle = "E-Commerce App";
  }


}