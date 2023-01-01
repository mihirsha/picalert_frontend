// ignore_for_file: camel_case_types, unused_import, use_build_context_synchronously, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:picalertapp/MenuPage.dart';
import 'package:picalertapp/login.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/sharedPreferences.dart';

class settings extends StatefulWidget {


  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
  
}

class _settingsState extends State<settings> {

    String email = "";
    String firstname = "";
    String lastname = "";


    @override
  void initState(){
    super.initState();
    retrievedata();
    
  }

  Future retrievedata() async{


    String info = UserSharedPreferences.getUsername() ?? '';

    var userInfo = json.decode(info);

    if (userInfo == ''){
      String token = UserSharedPreferences.getToken() ?? '';

      if (token == ''){

        await Future.delayed(const Duration(milliseconds: 700));
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginPage()));

      }else{

        await fetchUserInfo(token);

        setState(() {

          String info = UserSharedPreferences.getUsername() ?? '';
          var userInfo = json.decode(info);
        
          email = userInfo["email"];
          firstname = userInfo["firstname"];
          lastname = userInfo["lastname"];
          
      });


    }
    }else{
      setState(() {

          email = userInfo["email"];
          firstname = userInfo["firstname"];
          lastname = userInfo["lastname"];
          
      });
      

    }

    
  }
  Future _handleRefresh() async{
    
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: LiquidPullToRefresh(
          showChildOpacityTransition: true,
          height: 125,
          animSpeedFactor: 3,
          color: Colors.grey,
          onRefresh:_handleRefresh ,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  // color: Colors.blue,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top:25),
                    child: Column(
                    children: [
                      Lottie.asset("assets/user3.json", height:85,),
                      const SizedBox(height: 10,),
                        Text(
                          firstname[0].toUpperCase()+firstname.substring(1,firstname.length)+" "+lastname[0].toUpperCase()+lastname.substring(1,lastname.length),
                          style:TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                          )
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          email,
                          style:TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13, 
                          )
                        ),
                        const SizedBox(height: 30,),
                    ],
                  ),
                ),
            ),
            // ListView(
            //     children: [
            //       Container(
            //         color: Colors.red,height: 20,
            //         )
            //       ]
            //     ),
              ]
            )
          )
          )
      ),
    );
  }
    Future _Logout() async{
    QuickAlert.show(
      context: context,
      // closeontap:,
      
      type: QuickAlertType.warning,
      text: 'Sure you want to logout?',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () async {
        await clearData();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      },
      onCancelBtnTap: (){
        Navigator.pop(context);
      }
    );
  }

}


Future fetchUserInfo(String token) async {
  String urlFetchUserInfo = "https://picalertapp-backend.herokuapp.com/api/user/me/";
  var response =  await get(
    Uri.parse(urlFetchUserInfo),
    headers: {'Authorization': 'Token $token'},
  );

  // STORING TOKEN AND USERDATA
  await UserSharedPreferences.setUsername(response.body);
}

Future clearData() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.clear();
}




// Padding(
//   padding: const EdgeInsets.only(right: 200, left:30),
//   child: ElevatedButton.icon(
//     style: OutlinedButton.styleFrom(
//       backgroundColor:Colors.grey[300],
//       minimumSize: const Size.fromHeight(50),
//       shape: const StadiumBorder(),
//       side: BorderSide(
//         width: 2,
//         color:Colors.grey.shade400,
//         ),
//       ),
    
//     onPressed: _Logout,
//     label:  Text(
//       'Logout',
//       style: TextStyle(
//         color: Colors.grey.shade800,
//         ),

//       ),
//     icon: Icon(
//       Icons.lock,
//       size: 20,
//       color: Colors.grey[700],
//     ),
    
//   ),
// ),

class settingsButton extends StatelessWidget {
  const settingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Expanded(
        // padding: const EdgeInsets.symmetric(horizontal:30),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    color: Colors.red,height: 20,
                    )

                ],
              )
            
            )
          ],
        ) ,
      
      ) ,
      // color: Colors.blue,
    );
  }
}