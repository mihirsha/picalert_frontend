// // ignore_for_file: file_names, no_logic_in_create_state, use_build_context_synchronously, unrelated_type_equality_checks, unused_local_variable, prefer_typing_uninitialized_variables, dead_code, sort_child_properties_last, avoid_unnecessary_containers
// // deepshah995@gmail.com
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:http/http.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'package:quickalert/quickalert.dart';
// // import 'package:quickalert/widgets/quickalert_dialog.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'login.dart';


// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final String url = "https://picalertapp-backend.herokuapp.com/api/area/create-area/";
//   List data = [];

//   @override
//   void initState(){
//     super.initState();
//     retrievedata();
//   }

//   Future<String> retrievedata() async{
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         print('connected');
//       }
      
//     }on SocketException catch (_) {
//       QuickAlert.show(
//         context: context,
//         type: QuickAlertType.warning,
//         title: 'Warning!',
//         text: 'No Internet',
//         );
//     }


//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     // print(token);

//     if (token != Null){
//       String infoUrl = "https://picalertapp-backend.herokuapp.com/api/area/create-area/";
//       Response response =  await get(
//         Uri.parse(infoUrl),
//         headers: {'Authorization': 'Token $token'},
//       );
//       print(response.body);
//       storedata(response.body);
//       final List info = json.decode(response.body);
//       setState(() {
//         data = info.map<String>((item){
//           final title = item["title"];
//           return title;
//         }).toList();
//       });
      
//       // print(data);
      
//       return "Success";
//     }
//     else{
//       Navigator.of(context).pop();
//       Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
//       return "";
//     }
//     // Navigator.of(context).pop(true);
    
//   }




//   Future _handleRefresh() async{
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         print("Connected");
//       }
//     }on SocketException catch (_) {
//       QuickAlert.show(
//         context: context,
//         type: QuickAlertType.warning,
//         title: 'Warning!',
//         text: 'No Internet',
//         );
//     }



//     setState(() => data.clear());

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
    
//     if (token != Null){
//       String infoUrl = "https://picalertapp-backend.herokuapp.com/api/area/create-area/";
//       Response response =  await get(
//         Uri.parse(infoUrl),
//         headers: {'Authorization': 'Token $token'},
//       );
//       print(response.body);
//       final List info = json.decode(response.body);
//       setState(() {
//         data = info.map<String>((item){
//           final title = item["title"];
//           return title;
//         }).toList();
//       });
//     }else{  
//       Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
//       return "";
//     }

//   }

//   @override
//   Widget build(BuildContext context) {


//     // final String arr = await retrievetoken();
//     return Scaffold(

      
//       bottomNavigationBar: const GNav(
//         backgroundColor: Colors.white,
//         color: Colors.black,
//         activeColor: Colors.black,
//         tabBackgroundColor: Color.fromARGB(255, 225, 224, 224),
//         gap: 10,
//         tabs: [
//           GButton(icon: Icons.home, text: "Home",),
//           GButton(icon: Icons.settings_rounded, text: "Preferences",),
//           GButton(icon: Icons.search, text: "Search"),
//           // GButton(icon: Icons.home, text: "Preferences"),
//         ],
//       ),

//       body: LiquidPullToRefresh(
//         showChildOpacityTransition: false,
//         height: 100,
//         animSpeedFactor: 3,
//         color: Colors.grey,
//         onRefresh: _handleRefresh,
//         child: CustomScrollView(
//           semanticChildCount: data.length,
//           slivers: [
//             SliverAppBar.large(
//               backgroundColor: Colors.white,
//               leading: IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.menu),
//                 color: Colors.black,
      
//               ),
//               title: const Text(
//                 'Areas',
//                 style: TextStyle(fontSize: 25),
      
//                 ),
//               actions: [
//                 IconButton(
//                   onPressed: (){}, 
//                   icon: const Icon(Icons.more_vert),
//                   color: Colors.black,
//                 )
//               ],
//             ),
      
      
//             SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   childCount: data.length,
//                   (BuildContext context, int index){  
//                 return Container(
//                   child: Center(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: <Widget> [
//                         Card(
//                           margin: const EdgeInsets.symmetric(horizontal: 15),
//                           elevation: 10,
//                           shadowColor: Colors.black,
//                           child: Container(
//                             color: Colors.white,
                            
//                             child: Text(
//                               data[index].toUpperCase(),
//                               style: const TextStyle(fontSize: 14),
                              

//                             ),
//                             padding: const EdgeInsets.all(25.0),
//                             // height: 110,
//                           ),

    
//                         ),
//                       ],
//                     ),
                    
//                   ),
//                 );
//               },
//             ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Add your onPressed code here!
//         },
//         // label: const Text('Add'),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   void storedata(String data) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('data', data);
//   }
// }
