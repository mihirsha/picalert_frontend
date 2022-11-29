// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class indivArea extends StatelessWidget {
  final String text;
  // final bool isCompleted;

  const indivArea({
    Key? key,
    required this.text,
    // required this.isCompleted,
  }): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          // if(isCompleted==true)

          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black),

        ),
        child: Container(
          // color: Colors.grey,
          margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16 
                ),
              ),
              IconButton(
                onPressed: (){
                    //action coe when button is pressed
                }, 
                alignment: Alignment.centerRight,
                icon: const Icon(Icons.edit),
              )
            ],


            
          ),

          




        ),
    );
  }
}