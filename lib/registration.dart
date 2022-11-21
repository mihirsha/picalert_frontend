
// ignore: import_of_legacy_library_into_null_safe

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'login.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key?key}) : super(key: key);


  // This widget is the root of your application.
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>  {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();

  // ignore: non_constant_identifier_names
  Future sign_up() async{

      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String firstname = _firstnameController.text.trim();
      String lastname = _lastnameController.text.trim();

      if (email == "" || password == "" || firstname == "" || lastname == ""){
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(milliseconds: 1500), () {
              Navigator.of(context).pop(true);
            });
            return const CupertinoAlertDialog(
              title: Text('Please enter all fields'),
            );
          });
      }else{
        if (email.isValidEmail() == true){
          Register(email, password, firstname, lastname);

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
                  'Sign Up',
                  style : GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Join us for Free',
                  style : TextStyle(
                    fontSize:24,
                  ),
                ),
                const SizedBox(height: 30),
                
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
          
                const SizedBox(height: 15),
          
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
                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller:_firstnameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'First Name',
                      fillColor: Colors.grey[200],
                      filled: true
                    ),
                  ),
                ),
                const SizedBox(height: 15),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller:_lastnameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Last Name',
                      fillColor: Colors.grey[200],
                      filled: true
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: sign_up,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius:BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Center(
                          child: Text(
                            'Sign up',
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
                children: [
                  const Text(
                    'Already a Member?', 
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                    ' Login Now', 
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
  
  // ignore: non_constant_identifier_names
  Register(String email, String password, String firstname, String lastname) async {
    showDialog(
      context: context,
      builder: (context){
        return const Center(child: CircularProgressIndicator(),
        );
      }
    );
    String baseurl = "https://picalertapp-backend.herokuapp.com/api/user/create/";

    try{
      Response response =  await post(
        Uri.parse(baseurl),
        body: {
          'email' : email,
          'password' : password,
          'firstname': firstname,
          'lastname' : lastname,
        }
      );

      if (response.statusCode == 201){
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 4), () {
              Navigator.of(context).pop(true);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            });
            return const CupertinoAlertDialog(
              title: Text("New User Created"),
            );
          });
        
        // print("Create User");

        // ignore: use_build_context_synchronously
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));

      }else if(response.statusCode == 400){
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(milliseconds: 1500), () {
              Navigator.of(context).pop(true);
              Navigator.of(context).pop(true);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            });
            return const CupertinoAlertDialog(
              title: Text('User Already Exists !!'),
            );
          });
        
        // print(response.body);
        // print("User already Registered !!");
      }
      else{
        showDialog(
          context: context, 
          builder: (context) => const CupertinoAlertDialog(
            title: Text("some issue occured please register after sometime"),
            content: Text(""),
          )
        );
        
        print("Error");
      }

    }catch(e){
      print(e.toString());
    
    return false;

    }
  }
}
