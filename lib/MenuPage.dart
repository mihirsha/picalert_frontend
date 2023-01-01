// ignore_for_file: non_constant_identifier_names, file_names, unused_import, prefer_interpolation_to_compose_strings



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:picalertapp/Areas.dart';
import 'package:picalertapp/HomePage.dart';
import 'package:picalertapp/settings/settings.dart';
import 'package:picalertapp/utils/sharedPreferences.dart';
import 'package:picalertapp/widgets/widgets.dart';

// var data = [];

String firstname = "";
String lastname = "";
String email = "";

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, });
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {


  String username = "";

  @override
  void initState(){
    super.initState();
    
    username = UserSharedPreferences.getUsername() ?? '';
    var data = json.decode(username);
    if (data != ""){
      firstname = data["firstname"];
      lastname = data["lastname"];
      email = data["email"];
    }else{

    }


    // retrievedata();

  }

  
  MenuItem currentSelectedItem = MenuItems.areas;
  @override
  Widget build(BuildContext context) => ZoomDrawer(
    style: DrawerStyle.Style1,
    angle: 0,
    borderRadius: 20,
    slideWidth: MediaQuery.of(context).size.width*0.5,
    backgroundColor: Colors.grey.shade400,
    // showShadow: true, 
    mainScreen: getScreen(),
    menuScreen: Builder(
      builder: (context) => MenuBackPage(
          currentItem: currentSelectedItem,
          onSelectedItem: (item){
            setState(() => currentSelectedItem = item);
            ZoomDrawer.of(context)!.close();
          }, 
      ),
    ), 
  ); 

  Widget getScreen(){
    switch(currentSelectedItem){
      case MenuItems.areas: return const Areas(); 
      case MenuItems.home: return  bottomNavigationBar(idx: 0,); 
      case MenuItems.settings: return bottomNavigationBar(idx: 1); 
      case MenuItems.profile: return bottomNavigationBar(idx: 2); 
      default : return const Areas(); 
    }
  }

}


class MenuItems{
  static const areas = MenuItem('Areas', Icons.location_on_outlined);
  static const settings = MenuItem('Settings', Icons.settings);
  static const profile = MenuItem('Profile', Icons.person);
  static const home = MenuItem('Home', Icons.home_filled);
  static const all = <MenuItem>[
    home,
    profile,
    areas,
    settings,
    
  ];
}

class MenuItem{
  final String title;
  final IconData icon;
  const MenuItem(this.title, this.icon);
}

class MenuBackPage extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MenuBackPage({
    Key? key, 
    required this.currentItem,
    required this.onSelectedItem
  }): super(key: key);

  @override
  Widget build(BuildContext context) => Theme(
    data: ThemeData.light(),
    child: Scaffold(
    backgroundColor: Colors.grey.shade200,
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children:[
                Lottie.asset("assets/user3.json", height:80,),
                const SizedBox(height: 10,),
                Text(
                  // data["firstname"],
                  firstname[0].toUpperCase()+firstname.substring(1,firstname.length)+" "+lastname[0].toUpperCase()+lastname.substring(1,lastname.length),
                  // style: GoogleFonts.belgrano(fontSize: 10, color:Colors.black,),
                  style:const  TextStyle(
                    color:Colors.black,
                    fontSize: 18,
                    
                    fontWeight: FontWeight.bold

                  ),
                ),
                const SizedBox(height: 5,),
                
                Text(
                  email,
                  style: GoogleFonts.belgrano(fontSize: 10, color:Colors.black,),
                  // belgrano
                  // Bitter
                  // bigShouldersDisplay
                  // bebasNeue
                  // bellefair
                  // belleza
                  // bellota
                  // bellotaText
                  // Bilbo
                  // benchNine
                  // benne
                  // bentham
                  // berkshireSwash
                  // besley
                  // BethEllen
                  // Bevan
                  // bhuTukaExpandedOne


                  // style: const TextStyle(
                  //   color:Colors.black,
                  //   fontSize: 10,
                  //   fontWeight: FontWeight.bold,
                  //   overflow: TextOverflow.ellipsis,

                  // ),
                ),
              ]
            )
            
          ),
          
          
          

          const Spacer(),
          ...MenuItems.all.map(buildMenuItem).toList(),
          const Spacer(flex: 4),
          ],
        ),
      ),
    ),
  );

Widget buildMenuItem(MenuItem item) => ListTileTheme(
  selectedColor: Colors.grey.shade800,
  selectedTileColor: Colors.grey.shade300,
  child: ListTile(
    selected: currentItem == item ,
    minLeadingWidth: 20,
    leading: Icon(item.icon),
    title: Text(
      item.title,
      style:const TextStyle(fontSize: 18, color: Colors.black)
    ),
    // onTap: ()=>{},
    onTap: ()=> onSelectedItem(item),
  ),
);

}
