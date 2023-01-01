// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

bool isValidEmail(String email, context) {
     if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email) == true ){

          return true;
        }else{
          MotionToast(
              icon:  Icons.email_outlined,
              title:  const Text("Invalid Email", style: TextStyle(fontWeight: FontWeight.bold),),
              description:  const Text("Please enter valid a Email"),
              width:  300,
              height:  80,
               primaryColor: Colors.orange.shade200,
              position: MotionToastPosition.top,
              animationType:  AnimationType.fromTop,
              dismissable: false
            ).show(context);

          return false;
        }
  }

