
import 'package:app_e_commerce/modules/login/view_model/login_view_model.dart';
import 'package:app_e_commerce/modules/register/view/register_view.dart';
import 'package:app_e_commerce/widgets/subtitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/header_title_widget.dart';


class LoginView extends StatelessWidget{
  LoginView({super.key});
  var loginViewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text("Login",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Obx((){
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeaderTitleWidget(title: "Login"),
              SubtitleWidget(subtitle: "to E-Commerce App"),
              SizedBox(
                height: 35,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: TextField(onChanged: (value){
                  loginViewModel.onChangeValueUsername(value);
                },
                  controller: loginViewModel.usernameController.value,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.supervised_user_circle),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: TextField(
                  onChanged: (value){
                    loginViewModel.onChangeValuePassword(value);
                  },
                  controller: loginViewModel.passwordController.value,
                  obscureText: loginViewModel.enablePassword.value,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: (){
                          var value = loginViewModel.enablePassword.value;
                          loginViewModel.onEnablePassword(!value);
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: ElevatedButton(
                  onPressed: (){
                    loginViewModel.onLogin();
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text("Login",
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
                    Get.to(() => RegisterView());
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
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      )
                  ),
                ),
              ),
              // SubtitleWidget(
              //   subtitle: "${loginViewModel.username.value}",
              // )
            ],
          ),
        );
      })
    );
  }
}