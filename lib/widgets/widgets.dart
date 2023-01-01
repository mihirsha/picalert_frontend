// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_element, use_key_in_widget_constructors, camel_case_types, unused_import, unused_local_variable, must_be_immutable, sized_box_for_whitespace

// import 'dart:html';


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:picalertapp/Areas.dart';
import 'package:picalertapp/HomePage.dart';
import 'package:picalertapp/Preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../settings/settings.dart';

Widget skimmerLoad() => ListTile(
  title: ShimmerWidget.rectangular(height: 16),
  subtitle: ShimmerWidget.rectangular(height: 14),
);

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerWidget.rectangular({
    this.width = 10,
    required this.height
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.grey[200]!,
    highlightColor:  Colors.grey[100]!,
    child:Container(
      width: width,
      height: height,
      color: Colors.grey[300],

    ),
  );
}


class MenuWidget extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) =>  IconButton(
    icon: Icon(Icons.menu, color: Colors.black,),
    onPressed: () => ZoomDrawer.of(context)?.toggle()
  );
}



class bottomNavigationBar extends StatefulWidget {
  
  int idx;
  bottomNavigationBar({
    super.key,
    required this.idx
    
  });
  

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBar();
}

class _bottomNavigationBar extends State<bottomNavigationBar> {
  int? index;

  
  final screens = [
    
    HomePage(), 
    // Center(child: Text("Preferences", style: TextStyle(fontSize: 52),)),
    settings(),
    Center(child: Text("Profile", style: TextStyle(fontSize: 52),)),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screens[widget.idx],
        bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      //color: Color.fromRGBO(24, 233, 111, 0.35),
                      color: Colors.grey[400],
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: GNav(
                      selectedIndex: widget.idx,
                      haptic: false,
                      gap: 8,
                      activeColor: Colors.black,
                      hoverColor: Colors.grey,
                      tabBorderRadius: 7,
                      onTabChange: (index) {setState(() => widget.idx = index);},
                      duration: const Duration(milliseconds: 400),
                      color: Colors.black,
                      tabs: const [
                        GButton(icon: Icons.home, text: "Home",),
                        GButton(icon: Icons.settings, text: "Preferences",),
                        GButton(icon: Icons.person, text: "Profile"),
                      ],
                    ),
                  ),
                ),
          )
        ),
    );
  }
}


enum ButtonState{init, loading, done}


class MyWidget extends StatefulWidget {

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  ButtonState state = ButtonState.init;

  @override
  Widget build(BuildContext context) {
    final isStretched = state == ButtonState.init;
    final isDone = state == ButtonState.done;


    return Container(
      width: 100,
      height: 20,
      child: isStretched ? buildButton() : progbar(isDone),
    );

  }


Widget progbar(isDone){
  final color = isDone?Colors.green : Colors.deepPurple;


  return Container(
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    child: isDone
      ? Icon(Icons.done, size: 52, color:Colors.white):
      CircularProgressIndicator(color: Colors.white,),
  );
}




Widget buildButton() => OutlinedButton(
  style: OutlinedButton.styleFrom(
    shape: StadiumBorder(),
    side: BorderSide(width: 2, color:Colors.deepPurple),
  ),
  child: Text(
    'SUBMIT',
    style: TextStyle(
      fontSize: 24,
      color:Colors.deepPurple,
      letterSpacing: 1.5,
      fontWeight:FontWeight.w600,
    ),
  ),
  onPressed: () async {
    setState(() => state = ButtonState.loading);
    await Future.delayed(Duration(seconds: 3));
    setState(() => state = ButtonState.done);
    await Future.delayed(Duration(seconds: 3));
    setState(() => state = ButtonState.init);

  }
);
}



Future check_internet(BuildContext context) async {
      try {
        final result = await InternetAddress.lookup('example.com');
        return false;


      }on SocketException catch (_) {
        

            MotionToast(
              icon: Icons.wifi_tethering_error_sharp,
              // icon:  Icons.network_wifi_1_bar_rounded,
              title:  const Text("No Internet", style: TextStyle(fontWeight: FontWeight.bold),),
              description:  const Text("Please connect to internet"),
              width:  300,
              height:  80,
               primaryColor: Colors.red.shade200,
              position: MotionToastPosition.top,
              animationType:  AnimationType.fromTop,
              dismissable: false
            ).show(context);

        return true;

      }
}

