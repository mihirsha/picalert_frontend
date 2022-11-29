// ignore_for_file: file_names, no_logic_in_create_state, use_build_context_synchronously, unrelated_type_equality_checks, unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {


    // final String arr = await retrievetoken();
    return Scaffold(
      
      bottomNavigationBar: const GNav(
        backgroundColor: Colors.white,
        color: Colors.black,
        activeColor: Colors.black,
        tabBackgroundColor: Color.fromARGB(255, 225, 224, 224),
        gap: 10,
        tabs: [
          GButton(icon: Icons.home, text: "Home",),
          GButton(icon: Icons.settings_rounded, text: "Preferences",),
          GButton(icon: Icons.search, text: "Search"),
          // GButton(icon: Icons.home, text: "Preferences"),
        ],
      ),

      body: CustomScrollView(
        slivers: [

          SliverAppBar.large(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
              color: Colors.black,

            ),
            title: const Text(
              
              'Areas',
              style: TextStyle(fontSize: 25),

              ),
            actions: [
              IconButton(
                onPressed: fetchdata, 
                icon: const Icon(Icons.more_vert),
                color: Colors.black,
              )
            ],
          ),


          SliverToBoxAdapter(
            child: Column(
              
            )
          )
        ],
      ),
    );
  }

  Future fetchdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedList = prefs.getString('data');
    
    if (String == Null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }else{
      var list = jsonDecode(encodedList!);
      // ignore: void_checks
      List titleData = [];
      // for (int i = 0; i<list.length;i++){
      //   arr.add(list[i]["title"]);
      // }
      // print(arr);
      return list;

    }
  }

  void storedata(String data) async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', data);
  }



  // ignore: non_constant_identifier_names
  Future Storedata(token) async{
    if (token == Null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));

    }else{
    String infoUrl = "https://picalertapp-backend.herokuapp.com/api/area/create-area/";
    Response response =  await get(
      Uri.parse(infoUrl),
      headers: {'Authorization': 'Token $token'},

    );
    print(response.body);
    storedata(response.body);
    var list = jsonDecode(response.body);
    return list;

  }
  }
}

  void retrievetoken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? info = prefs.getString('token');
    
    if (info != Null){
      var map= json.decode(info!);
      String token = map['token'];
      // return token;
    }
    else{  
      // return "";    
    }
    
  }



