// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picalertapp/HomePage.dart';
import 'package:picalertapp/login.dart';
import 'package:picalertapp/splashScreen.dart';
import 'package:picalertapp/utils/sharedPreferences.dart';

Future main() async{

  String token = "";
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  
  await UserSharedPreferences.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: splashScreen(),
      );
    }
}