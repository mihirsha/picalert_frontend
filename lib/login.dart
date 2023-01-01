


// ignore: import_of_legacy_library_into_null_safe

// ignore_for_file: use_build_context_synchronously, unused_local_variable, sort_child_properties_last, deprecated_member_use, prefer_const_constructors, unused_import, depend_on_referenced_packages, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:picalertapp/Areas.dart';
import 'package:picalertapp/HomePage.dart';
import 'package:picalertapp/MenuPage.dart';
import 'package:picalertapp/utils/sharedPreferences.dart';
import 'package:picalertapp/utils/utils.dart';
import 'package:picalertapp/widgets/widgets.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'registration.dart';

enum ButtonState{init, loading, done}

class LoginPage extends StatefulWidget {
  const LoginPage({Key?key}) : super(key: key);


  // This widget is the root of your application.
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  {
  bool _clicked = false;
  bool isAnimating = true;
  ButtonState state = ButtonState.init;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String token = "";
  bool passwordVisible = false;
  
  
  @override
  void initState() {
    super.initState();
    bool passwordVisible = false;
    
  }
  
  Future sign_in() async{
      setState(() => state = ButtonState.loading);
      

      // READING INPUT EMAIL AND PASSWORD
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      // EMAIL VALIDITY
      bool getValidity = isValidEmail(email, context);

      if (getValidity == true){
          
          //CHECKING FOR EMAIL AND PASSWORD TO MATCH
          await login(email, password);

          // IF EMAIL AND PASSWORD HAS MATCHED
          if (token != ""){

            // CHECKING IF INTERNET IS CONNECTED OR NOT
            bool check = await check_internet(context);
            if (check){return;}
            
            // FETCHING USER DATA
            String userInfo = await fetchUserInfo(token);
            
            // NAVIGATING TO THE NEXTPAGE
            storeToken(token);
            storeUserData(userInfo);
            await Future.delayed(Duration(milliseconds: 1));
            setState(() => state = ButtonState.done);
            await Future.delayed(Duration(seconds: 1));
            setState(()=> _clicked = false);
            setState(() => state = ButtonState.init);
            print(token);
            // await Future.delayed(Duration(milliseconds: 200));
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  bottomNavigationBar(idx: 0)));
        }
      }else{
        setState(()=> _clicked = false);
        setState(() => state = ButtonState.init);
      }

      

  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isStretched = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.done;
    DateTime loginClickTime;


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
                    // initialValue: 'user@example.com',
                    // keyboardType: TextInputType.multiline,
                    enabled: (state == ButtonState.loading) ? false : true,
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: (Icon(Icons.email_outlined, color: Colors.deepPurple[200],)),
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey, ),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.deepPurple[800]),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                        
                      ),
                      
                      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                
                const SizedBox(height: 25),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    enabled: (state == ButtonState.loading) ? false : true,

                    controller:_passwordController,
                    obscureText: !passwordVisible,
                    decoration: InputDecoration(
                      prefixIcon: (Icon(Icons.security_outlined, color: Colors.deepPurple[200],)),
                      suffixIcon: IconButton(
                        padding: const EdgeInsets.only(right: 10),
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          passwordVisible 
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                          color: Colors.black54,
                          ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                              passwordVisible = !passwordVisible;
                          });
                        },
                        ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey, ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.deepPurple[800]),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                        
                      ),
                      
                      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),

            Container(
              // color: Colors.yellow,
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)),
              width: 200,
              height: 70,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeIn,
                width: state == ButtonState.init ? width: 70,
                onEnd: () => setState(()=>isAnimating=!isAnimating),
                child: isStretched ? buildButton() : progbar(isDone),
              )
            ),


            const SizedBox(height: 25),


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


 
 

  

  void storeToken(String token) async {
    await UserSharedPreferences.setToken(token);
  }

  void storeUserData(String data) async {
    await UserSharedPreferences.setUsername(data);
  }

  Future login(String email, String password) async {

    // CHECKING IF INTERNET IS CONNECTED OR NOT
    bool check = await check_internet(context);
    if (check){return;}

    String urlFetchUserToken = "https://picalertapp-backend.herokuapp.com/api/user/token/";
    
    Response response =  await post(
      Uri.parse(urlFetchUserToken),
      body: { 'email' : email, 'password' : password }

    );

    if (response.statusCode == 200){
      setState((){
        var data = json.decode(response.body);
        token = data["token"];
      });
    }else{
        print("print");
        MotionToast(
          icon:  Icons.lock_outlined,
          title:  const Text("Wrong credentials", style: TextStyle(fontWeight: FontWeight.bold),),
          description:  const Text("You have entered incorrect email or password"),
          width:  300,
          height:  80,
            primaryColor: Colors.red.shade200,
          position: MotionToastPosition.top,
          animationType:  AnimationType.fromTop,
          dismissable: false
        ).show(context);
        // setState(() => state = ButtonState.done);
        setState(() => state = ButtonState.init);
        setState(()=> _clicked = false);

      }
    
  }




Widget progbar(isDone){
  final color = isDone?Colors.green : Colors.deepPurple;
  return Container(
    // height: 20,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    child: Center(
      child: isDone
      ? Icon(Icons.done, size: 32, color:Colors.white):
      SizedBox(
        child: CircularProgressIndicator(color: Colors.white,),
        height: 25.0,
        width: 25.0, )
    )
  );
}




Widget buildButton() => OutlinedButton(
  
  style: OutlinedButton.styleFrom(
    minimumSize: Size.fromHeight(60),
    shape: StadiumBorder(),
    side: BorderSide(width: 2,color:Colors.deepPurple),
  ),
  
  child: FittedBox(
    child: Text(
      'Sign in',
      style: TextStyle(
        fontSize: 20,
        color:Colors.indigo,
        // letterSpacing: 1.5,
        fontWeight:FontWeight.w600,
      ),
    ),
  ),
  onPressed: () async {
    if (_clicked == true){
      return ;
    }else{
      setState(()=> _clicked = true );
      sign_in();
    }
    // setState(() => state = ButtonState.loading);
    // await Future.delayed(Duration(seconds: 3));
    // setState(() => state = ButtonState.done);
    // await Future.delayed(Duration(seconds: 3));
    // setState(() => state = ButtonState.init);

  }
);

}

Future fetchUserInfo(String token) async {
  String urlFetchUserInfo = "https://picalertapp-backend.herokuapp.com/api/user/me/";
  Response response =  await get(
    Uri.parse(urlFetchUserInfo),
    headers: {'Authorization': 'Token $token'},
  );
  return response.body;

}