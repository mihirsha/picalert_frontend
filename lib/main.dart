
import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   scaffoldBackgroundColor: Color(0xFFD2FFF4) , 
      //   textTheme: Theme.of(context).textTheme.apply(bodyColor: Color(0xFF2D5D70)),
      // ),
      home:  LoginPage(),
    );
  }
}