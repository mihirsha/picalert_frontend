// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, camel_case_types, unused_import, unnecessary_import, file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:picalertapp/HomePage.dart';
import 'package:picalertapp/login.dart';
import 'package:picalertapp/utils/sharedPreferences.dart';
import 'package:picalertapp/widgets/widgets.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {


     @override
  void initState() {
    super.initState();
    start(context);
    
  }

  Future start(BuildContext context) async{

    String token = "";
    await UserSharedPreferences.init();
    token = UserSharedPreferences.getToken()??"";

    if (token == ""){
      Timer(
        Duration(seconds:4),
        () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()))
      );
    }else{
      Timer(
        Duration(seconds:3),
        () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  bottomNavigationBar(idx: 0,)))
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 1000,
        child: Column(
          children:[
            SizedBox(height: 50),
            Container(
              child: Lottie.asset("assets/Rocket.json"),
            ),
            SizedBox(height: 20),
            Container(
              child: Column(
                children: const [
                  Text("Launching",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text("PicAlert",style: TextStyle(color:Colors.black, fontSize: 30,fontWeight: FontWeight.bold),),
                ]
              )
            ),
          ]
        )
      ),
    );
  }
}