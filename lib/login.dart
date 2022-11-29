


// ignore: import_of_legacy_library_into_null_safe

// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homePage.dart';
import 'registration.dart';


// List arr = [];
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key?key}) : super(key: key);


  // This widget is the root of your application.
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // ignore: non_constant_identifier_names
  Future sign_in() async{

      String token = "";
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      if (email.isValidEmail() == true){

        String tokenDict = await login(email, password);
        if (tokenDict != ""){
          var map = jsonDecode(tokenDict);
          token = token + map["token"];
          if (token != ""){
            String urlFetchUserInfo = "https://picalertapp-backend.herokuapp.com/api/user/me/";
            Response response =  await get(
              Uri.parse(urlFetchUserInfo),
              headers: {'Authorization': 'Token $token'},
            );
            var infoDetails = jsonDecode(response.body);
            print(infoDetails["email"]);
            storeToken(token);
            // ignore: await_only_futures
            // await Storedata(token);
            // print(arr);
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
          }else{
          showDialog(
            context: context,
            builder: (context) {
              Future.delayed(const Duration(milliseconds: 1500), () {
                Navigator.of(context).pop(true);
              });
              return const CupertinoAlertDialog(
                title: Text("Incorrect Credentials"),
              );
            
            });

          }
        }else{
          showDialog(
            context: context,
            builder: (context) {
              Future.delayed(const Duration(milliseconds: 1500), () {
                Navigator.of(context).pop(true);
                
              });
              return const CupertinoAlertDialog(
                title: Text("Incorrect Credentials"),
              );
            });
          } 
      }else{
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(milliseconds: 1500), () {
              Navigator.of(context).pop(true);
            });
            return const CupertinoAlertDialog(
              title: Text("Invalid Email"),
            );
          });
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],//Color(0xFFD2FFF4)
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // mainAxisAlignment: MainAxisAlignment.center,
                // Image.asset('images/favicon.png'),  
                Text(
                  'PicAlert',
                  style : GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome back !!',
                  style : TextStyle(
                    fontSize:24,
                  ),
                ),
                const SizedBox(height: 50),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Email',
                      fillColor: Colors.grey[200],
                      filled: true
                    ),
                  ),
                ),
          
                const SizedBox(height: 10),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller:_passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Password',
                      fillColor: Colors.grey[200],
                      filled: true
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: sign_in,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius:BorderRadius.circular(12),
                        // border: Border.all(color: Colors.black)
                      ),
                      child: const Center(
                        child: Center(
                          child: Text(
                            'Sign in',
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
              ),
              const SizedBox(height: 25),


            ElevatedButton(
            child: Text('Sign in'),
            onPressed: sign_in,
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.black)
                )
                ),

                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(25)
                ),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    ),
                  ),
                ),
            ),


          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not a Member?', 
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationPage()));
                    },
                    child: const Text(
                    ' Register Now', 
                    style: TextStyle(
                      color : Colors.blue ,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  ],
                ),
            
              ],
            ),
          ),
        ),
      )
    );
  }

  login(String email, String password) async {

    showDialog(
      context: context,
      builder: (context){
        return const Center(child: CircularProgressIndicator(),
        );
      }
    );

    String urlFetchUserToken = "https://picalertapp-backend.herokuapp.com/api/user/token/";

    try{
      Response response =  await post(
        Uri.parse(urlFetchUserToken),
        body: {
          'email' : email,
          'password' : password,
        }
      );

      if (response.statusCode == 200){
        // print(response.body);
        return response.body;

      }
      else{
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(milliseconds: 1500), () {
              Navigator.of(context).pop(true);
            });
            return const CupertinoAlertDialog(
              title: Text("Incorrect Credentials"),
            );
          });
        print("Issue");
        Navigator.of(context).pop(true);
        Navigator.of(context).pop(true);
        return "";
      }

    }catch(e){

      Navigator.of(context).pop();
      print(e.toString());

    }
    
  }

  void storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
