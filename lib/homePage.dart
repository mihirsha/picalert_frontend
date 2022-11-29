// ignore_for_file: file_names, no_logic_in_create_state, use_build_context_synchronously, unrelated_type_equality_checks, unused_local_variable, prefer_typing_uninitialized_variables, dead_code, sort_child_properties_last, avoid_unnecessary_containers
// deepshah995@gmail.com
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
  final String url = "https://picalertapp-backend.herokuapp.com/api/area/create-area/";
  List data = [];

  @override
  void initState(){
    super.initState();
    this.retrievedata();
  }

  Future<String> retrievedata() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // print(token);

    if (token != Null){
      String infoUrl = "https://picalertapp-backend.herokuapp.com/api/area/create-area/";
      Response response =  await get(
        Uri.parse(infoUrl),
        headers: {'Authorization': 'Token $token'},
      );
      print(response.body);
      storedata(response.body);
      setState(() {
        var info = jsonDecode(response.body);
        for(int i=0; i<info.length; i++){
          data.add(info[i]["title"]);
        }
      });
      
      // print(data);
      return "Success";
    }
    else{  
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      return "";
    }
    // Navigator.of(context).pop(true);
    
  }



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
        semanticChildCount: data.length,
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
                onPressed: (){}, 
                icon: const Icon(Icons.more_vert),
                color: Colors.black,
              )
            ],
          ),


          SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: data.length,
                (BuildContext context, int index){  
              return Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget> [
                      Card(
                        child: Container(
                          child: Text(data[index]),
                          padding: const EdgeInsets.all(20.0),

                        ),
                      ),
                    ],
                  ),
                  
                ),
              );
            },
          ),
          ),
        ],
      ),
    );
  }

  void storedata(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', data);
  }
}
