// ignore_for_file: file_names, no_logic_in_create_state, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:http/http.dart';
import 'area_Indiv_design.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';


class HomePage extends StatefulWidget {
  

  List arr;

  HomePage({super.key, required this.arr});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
  // getdata();
  @override
  Widget build(BuildContext context) {
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
              children: [
                for(int i = 0; i < arr.length; i++)
                  indivArea(text: arr[i]),

                GestureDetector(
                  onTap: (){},
                  child: Container(
                    margin: const EdgeInsets.only(left: 330, right:20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius:BorderRadius.circular(100),
                      // border: Border.all(color: Colors.black)
                    ),
                    child: const Center(
                      child: Center(
                        child: Text(
                          '+',
                          style: TextStyle(
                            color : Colors.white ,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                      ),
                    ),
                      
                    ),
                  ),
                ),
              ],
              
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

}

