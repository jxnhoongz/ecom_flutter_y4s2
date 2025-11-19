
import 'package:app_e_commerce/repository/auth_repositoryImpl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterViewModel extends GetxController{
  var usernameController = TextEditingController().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var username = "".obs;
  var firstName = "".obs;
  var lastName = "".obs;
  var email = "".obs;
  var phoneNumber = "".obs;
  var password = "".obs;
  var confirmPassword = "".obs;
  var enablePassword = true.obs;
  var enableConfirmPassword = true.obs;
  var authRepository = AuthRepositoryImpl();

  @override
  void onInit() {
    super.onInit();
  }

  onChangeValueUsername(String value){
    username.value = value;
  }
  onChangeValueFirstName(String value){
    firstName.value = value;
  }
  onChangeValueLastName(String value){
    lastName.value = value;
  }
  onChangeValueEmail(String value){
    email.value = value;
  }
  onChangeValuePhoneNumber(String value){
    phoneNumber.value = value;
  }
  onChangeValuePassword(String value){
    password.value = value;
  }
  onChangeValueConfirmPassword(String value){
    confirmPassword.value = value;
  }
  onEnablePassword(value){
    enablePassword.value = value;
  }
  onEnableConfirmPassword(value){
    enableConfirmPassword.value = value;
  }

  onRegister() async{
    username.value = usernameController.value.text;
    firstName.value = firstNameController.value.text;
    lastName.value = lastNameController.value.text;
    email.value = emailController.value.text;
    phoneNumber.value = phoneNumberController.value.text;
    password.value = passwordController.value.text;
    confirmPassword.value = confirmPasswordController.value.text;

    if(username.isEmpty){
      showMassageError("Username is required.");
      return;
    }
    if(firstName.isEmpty){
      showMassageError("First name is required.");
      return;
    }
    if(lastName.isEmpty){
      showMassageError("Last name is required.");
      return;
    }
    if(email.isEmpty){
      showMassageError("Email is required.");
      return;
    }
    if(phoneNumber.isEmpty){
      showMassageError("Phone number is required.");
      return;
    }
    if(password.isEmpty){
      showMassageError("Password is required.");
      return;
    }
    if(confirmPassword.isEmpty){
      showMassageError("Confirm password is required.");
      return;
    }
    if(password.value != confirmPassword.value){
      showMassageError("Passwords do not match.");
      return;
    }

    var registerRes = await authRepository.register(
      username.value,
      firstName.value,
      lastName.value,
      email.value,
      phoneNumber.value,
      password.value,
    );

    if(registerRes.isSuccess == true){
      showMassageSuccess("Registration Successful!");
      Get.back();
    } else {
      showMassageError("Registration failed. Please try again.");
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
