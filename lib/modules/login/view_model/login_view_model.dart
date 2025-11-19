
import 'package:app_e_commerce/repository/auth_repositoryImpl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController{
  var usernameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var username = "".obs;
  var password = "".obs;
  var enablePassword = true.obs;
  var authRepository = AuthRepositoryImpl();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  onChangeValueUsername(String value){
    username.value = value;
  }
  onChangeValuePassword(String value){
    password.value = value;
  }
  onEnablePassword(value){
    enablePassword.value = value;
  }

  onLogin() async{
    username.value = usernameController.value.text;
    password.value = passwordController.value.text;
    if(username.isEmpty){
      showMassageError("Username is required.");
      return;
    }
    if(password.isEmpty){
      showMassageError("Password is required.");
      return;
    }
    var loginRes = await authRepository.login(username.value, password.value);
    if(loginRes.accessToken != null){
      showMassageSuccess("Login Successfully.");
      Get.offAllNamed("/");
    } else {
      showMassageError("Username and password incorrect.");
    }

  }
  showMassageError(String message){
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.red,
      margin: EdgeInsets.symmetric(vertical: 20,horizontal: 16)
    );
  }
  showMassageSuccess(String message){
    Get.snackbar(
        "Success",
        message,
        backgroundColor: Colors.black12,
        margin: EdgeInsets.symmetric(vertical: 20,horizontal: 16)
    );
  }
}