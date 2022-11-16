


// ignore: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

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
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      if (login(email, password) == true){
        print ("Connected....");
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
                  child: TextField(
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
                      hintText: 'Email',
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
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:const [
                  Text(
                    'Not a Member?', 
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' Register Now', 
                    style:TextStyle(
                      color : Colors.blue ,
                      fontWeight: FontWeight.bold,
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
    String baseurl = "http://127.0.0.1:8000/api/user/token/";

    try{
      Response response =  await post(
        Uri.parse(baseurl),
        body: {
          'email' : email,
          'password' : password,
        }
      );

      if (response.statusCode == 200){
        print("logged in");

      }
      else{
        print("issue");
      }

    }catch(e){
      print(e.toString());

    }
  }
}