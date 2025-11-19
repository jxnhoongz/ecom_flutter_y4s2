
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_mode/home_view_model.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  var homeViewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home",style: TextStyle(color: Colors.pink),),
        backgroundColor: Colors.lime,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
          onPressed: (){
            Get.toNamed("/login");
          },
        child: Icon(Icons.login,color:  Colors.white),
      ),
    );
  }
}
