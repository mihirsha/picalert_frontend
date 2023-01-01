// ignore_for_file: file_names, unnecessary_const, prefer_const_constructors_in_immutables, unused_local_variable, unrelated_type_equality_checks, use_build_context_synchronously, prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers, deprecated_member_use, unused_import, unnecessary_null_comparison, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:picalertapp/Areas.dart';
import 'package:picalertapp/MenuPage.dart';
import 'package:picalertapp/Preferences.dart';
import 'package:picalertapp/login.dart';
import 'package:picalertapp/utils/menu_mainbuttons.dart';
import 'package:picalertapp/utils/sharedPreferences.dart';
import 'package:picalertapp/widgets/widgets.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key,});
  @override
  State<HomePage> createState() =>  _HomePageState();
}

class _HomePageState extends State<HomePage> {  
  String token = "";
  String Userinfo = "";
  final double horizontalpadding = 40.0;
  final double verticalpadding = 25.0;
  Map<String, dynamic> data = {};
  @override
  void initState(){
    super.initState();
    Userinfo = UserSharedPreferences.getUsername() ?? '';
    token = UserSharedPreferences.getToken() ?? '';

    retrievedata();

  }
  // FUNCTION TO RETRIEVE USER INFORMATION
  Future<String> retrievedata() async{

    
    

    // CHECKING FOR INTERNET ACCESS
    const isLoading = true;
    bool check = await check_internet(context);
    if (check){return "" ;}
    
    
    // CHECKING IF USERINFO IS NOT STORED OR GOT DELETED
    if (Userinfo != ""){  
      
      // CONVERTING STRING JSON
      final Map<String, dynamic> newdata = jsonDecode(Userinfo);  
      setState(() { data = newdata; });
      return "Success";

    }
    // IF USERINFO IS DELETED RETRIEVEING TOKEN AND FETCHING USER DATA
    else{
      
      // CHECKING IF TOKEN IS NOT STORED OR GOT DELETED
      if (token != ""){

        // CHECKING IF INTERNET IS CONNECTED OR NOT
        bool check = await check_internet(context);
        if (check){return"";}
        
        // IF TOKEN RETRIEVED FETCHING USERINFO VIA API
        String infoUrl = "https://picalertapp-backend.herokuapp.com/api/user/me/";
        Response response =  await get(
          Uri.parse(infoUrl),
          headers: {'Authorization': 'Token $token'},
        );
        

        // STORING USERINFO IN SHARED PREFERENCES
        await UserSharedPreferences.setUsername(response.body);
        
        // CONVERTING RESPONSE BODY TO JSON AND SETTING THE STATE
        var info = json.decode(response.body);
        setState(() {
          data = info;
        });

        // RETURNING 
        return "";

      }else{

        // IF TOKEN DOES NOT EXIST NAVIGATING USER TO LOGIN PAGE TO LOGIN AGAIN
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
        
        // RETURNING 
        return "";
      }
    }
  }

  // FUNCTION TO RETRIEVE USER INFORMATION (REFRESH)
  Future _handleRefresh() async {
    
    // CHECKING FOR INTERNET ACCESS
    bool check = await check_internet(context);
    if (check){return "" ;}
    
    // CONVERTING STRING JSON
    final Map<String, dynamic> newdata = jsonDecode(Userinfo);

    //CHECKING IF DATA IS IS PRESENT IN SHARED PREFERENCES
    if (newdata != null){  
      setState(() {
        data = newdata;
      });

      // RETURNING 
      return "Success";

    }
    // IF DATA NOT PRESENT IN SHARED PREFERENCES
    else{

      // CHECKING IF TOKEN IS PRESENT IN SHARED PREFERENCES OR NOT
      if (token != null){

        // IF TOKEN PRESENT USING API TO RETRIEVE USERINFORMATION
        String infoUrl = "https://picalertapp-backend.herokuapp.com/api/user/me/";
        Response response =  await get(
          Uri.parse(infoUrl),
          headers: {'Authorization': 'Token $token'},
        );
      // CONVERTING RESPONSE BODY TO JSON
      final Map<String, dynamic> info = json.decode(response.body);
      setState(() {
        data = info;
      });

      // RETURNING
      return "";

      }
      // IF TOKEN NOT PRESENT 
      else{
        
        // NAVIGATE BACK TO LOGIN PAGE
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));

        // RETURNING
        return "";
      }
    }
  }
  


  


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        // bottomNavigationBar:const bottomNavigationBar(),
        body: LiquidPullToRefresh(
          color: Colors.grey[400],
          onRefresh: _handleRefresh,
          child: SingleChildScrollView(
            
            physics: AlwaysScrollableScrollPhysics(),
            child:SafeArea(
             child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome ,",
                              style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              (data["firstname"] == null || data["lastname"] == null) ? "User": data["firstname"]+" "+data["lastname"],
                              style: GoogleFonts.bebasNeue(fontSize: 50),
                              ),
                            ],
                          ),

                        ),
                      
                      Padding(
                        padding: EdgeInsets.only(right: 25),
                        child: Container(
                          padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(Icons.person),
                            ),
                      ),
                

                      ]
                    ),

                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 204, 204, 204),
                      ),
                    ),

                  const SizedBox(height: 10),
                  
                    
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "PicAlert",
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  SizedBox(height: 20),

                Row(
                  children: const [
                    cardbuild(
                      text: "Area",
                      onPressed: MenuPage(),
                    ),

                    cardbuild(
                      text: "Delivery",
                      onPressed: MenuPage(),
                    ),
                  ]
                ),
              ]
             ),
            ),
          ),
        ),
        
      ),
    );
  }
}


