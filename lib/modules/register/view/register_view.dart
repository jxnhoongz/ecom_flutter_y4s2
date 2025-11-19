
import 'package:app_e_commerce/modules/register/view_model/register_view_model.dart';
import 'package:app_e_commerce/widgets/subtitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/header_title_widget.dart';


class RegisterView extends StatelessWidget{
  RegisterView({super.key});
  var registerViewModel = Get.put(RegisterViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text("Register",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Obx((){
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeaderTitleWidget(title: "Register"),
              SubtitleWidget(subtitle: "to E-Commerce App"),
              SizedBox(
                height: 35,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: TextField(onChanged: (value){
                  registerViewModel.onChangeValueUsername(value);
                },
                  controller: registerViewModel.usernameController.value,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Username",
                      labelStyle: TextStyle(
                          color: Colors.black54
                      ),
                      hintText: "Enter your username",
                      hintStyle: TextStyle(
                          color: Colors.black
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                              color: Colors.black54,
                              width: 2.5
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)
                        ),
                      )
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: TextField(onChanged: (value){
                  registerViewModel.onChangeValueFirstName(value);
                },
                  controller: registerViewModel.firstNameController.value,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.badge),
                      labelText: "First Name",
                      labelStyle: TextStyle(
                          color: Colors.black54
                      ),
                      hintText: "Enter your first name",
                      hintStyle: TextStyle(
                          color: Colors.black
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                              color: Colors.black54,
                              width: 2.5
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)
                        ),
                      )
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: TextField(onChanged: (value){
                  registerViewModel.onChangeValueLastName(value);
                },
                  controller: registerViewModel.lastNameController.value,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.badge_outlined),
                      labelText: "Last Name",
                      labelStyle: TextStyle(
                          color: Colors.black54
                      ),
                      hintText: "Enter your last name",
                      hintStyle: TextStyle(
                          color: Colors.black
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                              color: Colors.black54,
                              width: 2.5
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)
                        ),
                      )
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: TextField(onChanged: (value){
                  registerViewModel.onChangeValueEmail(value);
                },
                  controller: registerViewModel.emailController.value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      labelStyle: TextStyle(
                          color: Colors.black54
                      ),
                      hintText: "Enter your email",
                      hintStyle: TextStyle(
                          color: Colors.black
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                              color: Colors.black54,
                              width: 2.5
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)
                        ),
                      )
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: TextField(onChanged: (value){
                  registerViewModel.onChangeValuePhoneNumber(value);
                },
                  controller: registerViewModel.phoneNumberController.value,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: "Phone Number",
                      labelStyle: TextStyle(
                          color: Colors.black54
                      ),
                      hintText: "Enter your phone number",
                      hintStyle: TextStyle(
                          color: Colors.black
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                              color: Colors.black54,
                              width: 2.5
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)
                        ),
                      )
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: TextField(
                  onChanged: (value){
                    registerViewModel.onChangeValuePassword(value);
                  },
                  controller: registerViewModel.passwordController.value,
                  obscureText: registerViewModel.enablePassword.value,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: (){
                          var value = registerViewModel.enablePassword.value;
                          registerViewModel.onEnablePassword(!value);
                        },
                          child: Icon(Icons.remove_red_eye)
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(
                          color: Colors.black54
                      ),
                      hintText: "Enter your password",
                      hintStyle: TextStyle(
                          color: Colors.black
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                              color: Colors.black54,
                              width: 2.5
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)
                        ),
                      )
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: TextField(
                  onChanged: (value){
                    registerViewModel.onChangeValueConfirmPassword(value);
                  },
                  controller: registerViewModel.confirmPasswordController.value,
                  obscureText: registerViewModel.enableConfirmPassword.value,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: InkWell(
                        onTap: (){
                          var value = registerViewModel.enableConfirmPassword.value;
                          registerViewModel.onEnableConfirmPassword(!value);
                        },
                          child: Icon(Icons.remove_red_eye)
                      ),
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(
                          color: Colors.black54
                      ),
                      hintText: "Confirm your password",
                      hintStyle: TextStyle(
                          color: Colors.black
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                              color: Colors.black54,
                              width: 2.5
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)
                        ),
                      )
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: ElevatedButton(
                  onPressed: (){
                    registerViewModel.onRegister();
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text("Register",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      )
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ElevatedButton(
                  onPressed: (){
                    Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text("Back to Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      )
                  ),
                ),
              ),
            ],
          ),
        );
      })
    );
  }
}
