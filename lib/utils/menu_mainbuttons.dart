
// ignore_for_file: sort_child_properties_last, prefer_const_constructors, camel_case_types, deprecated_member_use


import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class cardbuild extends StatelessWidget {
  final String text;
  final Widget onPressed;
  const cardbuild({super.key, required this.text, required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => onPressed));
          }, 
          child: Column( 
            children: [
              // const Padding(
              //   padding: EdgeInsets.only(top:20),
              // ),
              SizedBox(
                height: 120,
                child: OverflowBox(
                  minHeight:200,
                  maxHeight:200,
                  child: Lottie.asset(
                    'assets/final comp.json',
                    width:200,
                    height:200,
                  ),
                ),
              ),
              
              Text(
                text,
                style: TextStyle(
                  fontSize: 20
                ),
              ), 
            ],
          ),
          style:ElevatedButton.styleFrom(
            
            padding: EdgeInsets.symmetric(horizontal: 10),
            fixedSize: Size(120, 170),
            backgroundColor: Colors.grey.shade900,
            textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            primary: Colors.grey,
            onPrimary: Colors.white,
            elevation: 15,
            
            // shape: StadiumBorder(),
          ), 
        ),
      );

  }
}