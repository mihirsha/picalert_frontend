// ignore_for_file: file_names, no_logic_in_create_state, use_build_context_synchronously, unrelated_type_equality_checks, unused_local_variable, prefer_typing_uninitialized_variables, dead_code, sort_child_properties_last, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unnecessary_import, unused_import, unused_label, await_only_futures, unnecessary_const, no_leading_underscores_for_local_identifiers, unnecessary_new
// deepshah995@gmail.com
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/model/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/model/screen_hidden_drawer.dart';
import 'package:http/http.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:picalertapp/AddAreaItem.dart';
import 'package:picalertapp/HomePage.dart';
import 'package:picalertapp/MenuPage.dart';
import 'package:picalertapp/widgets/widgets.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';


class Areas extends StatefulWidget {
  const Areas({super.key});
  @override
  State<Areas> createState() => _AreasState();
}

class _AreasState extends State<Areas> {

  List data = [];
  List status = [];
  bool isLoading = false;
  bool hasConnection = false;
  StreamController connectionChangeController = new StreamController.broadcast();
  Stream get connectionChange => connectionChangeController.stream;


  @override
  void initState(){
    super.initState();
    retrievedata();
  }
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;
    

    try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            hasConnection = true;
        } else {
            hasConnection = false;
        }
    } on SocketException catch(_) {
        hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
        connectionChangeController.add(hasConnection);
    }

    return hasConnection;
}

  Future<String> retrievedata() async{
    isLoading = true;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // print(token);

    if (token != null){

      // CHECKING IF INTERNET IS CONNECTED OR NOT
      bool check = await check_internet(context);
      if (check){return"";}

      String infoUrl = "https://picalertapp-backend.herokuapp.com/api/area/create-area/";
      Response response =  await get(
        Uri.parse(infoUrl),
        headers: {'Authorization': 'Token $token'},
      );
      // print(response.body);
      storedata(response.body);
      final List info = json.decode(response.body);
      // print(data);
      setState(() {
        data = info;
      });
      isLoading = false;
      // print(data);
      
      return "Success";
    }
    else{
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      return "";
    }
    // Navigator.of(context).pop(true);
    
  }

  Future _handleRefresh() async{
    
    setState(() => data.clear());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    if (token != null){

      // CHECKING IF INTERNET IS CONNECTED OR NOT
      bool check = await check_internet(context);
      if (check){return;}

      String infoUrl = "https://picalertapp-backend.herokuapp.com/api/area/create-area/";
      Response response =  await get(
        Uri.parse(infoUrl),
        headers: {'Authorization': 'Token $token'},
      );
      print(isLoading);
      // List info = json.decode(response.body);

      List<dynamic> info = json.decode(response.body);
      // List<dynamic> data = map["dataKey"];
      print(token);
      print(info);
      setState(() {
        isLoading = false;
        data = info;
      });
      
      
    }else{  
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      return "";
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

    //  bottomNavigationBar:const bottomNavigationBar(),
      body: LiquidPullToRefresh(
        showChildOpacityTransition: true,
        height: 125,
        animSpeedFactor: 3,
        color: Colors.grey,
        onRefresh: _handleRefresh,
        child: CustomScrollView(
          // semanticChildCount: data.length,
          slivers: [
            SliverAppBar.medium(
              // toolbarHeight:100,
              backgroundColor: Colors.grey[100],
              // ignore: prefer_const_constructors
              leading: MenuWidget(), 
              title: const Text(
                'Areas',
                style: TextStyle(fontSize: 25),
                ),
              actions: [
                IconButton(
                  onPressed:_Logout,
                  icon: const Icon(Icons.power_settings_new),
                  color: Colors.black,
                  )
                ],
              ),

          SliverList(
            delegate: SliverChildListDelegate(
            List.generate((isLoading ? 10 : data.length) | (data.isEmpty ? 1 : data.length) ,(idx) {
                      if (data.isEmpty || isLoading){
                          if(isLoading){

                            Future<bool> check = checkConnection();
                            // print(check);
                            if (checkConnection() == false){
                              // print(checkConnection());
                            }
                            return skimmerLoad();
                          }
                      else{
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 90),
                          child: Center(
                            child: Lottie.asset("assets/Empty.json",),
                          ),
                        );
                      }
                      
                  }else{
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 10),
                      child: Card(
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                flex: 1,
                                onPressed: ((context) => {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.warning,
                                    text: 'Area ' + data[idx]["title"] + " will be deleted permanently",
                                    confirmBtnText: 'Yes',
                                    cancelBtnText: 'No',
                                    confirmBtnColor: Colors.green,
                                    onConfirmBtnTap: () async {
                                      await delete_item(data[idx]["id"]);

                                    },
                                   onCancelBtnTap: (){
                                    Navigator.pop(context);
                                    }
                                  ),

                                 
                              }),
                              icon: Icons.delete_outline_rounded,
                              backgroundColor: Colors.red.shade200,
                              
                              ),
                              SlidableAction(
                                flex: 1,
                                onPressed: ((context) => {
                              }),
                              icon: Icons.edit,
                              backgroundColor: Colors.grey.shade900,
                              
                              ),
                            ],
                          ),
                          
                          child: ListTile(
                            minVerticalPadding: 20,
                            leading: const Icon(Icons.location_city_rounded),
                            
                            trailing: (data[idx]["status"] == "COMPLETED" ) ? const Icon(Icons.done_outline_rounded): const Icon(Icons.not_interested_rounded),
                            title: Text(
                              data[idx]["title"].toUpperCase(),
                              style: const TextStyle(fontSize: 12),
                            ),
                            subtitle: Text(
                              "Status : " + data[idx]["status"].toUpperCase(),
                              style: const TextStyle(fontSize: 12),
                            ),
                            isThreeLine: true,
                            dense: true,
                            onTap:  () {},
                          ),
                        ),
                      ),
                    );   
                  }   
                },
              ),
            ),
          )
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAreaItem()));
        },
        // label: const Text('Add'),
        child: const Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
    );


}

  Future _Logout() async{
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      text: 'Sure you want to logout?',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () async {
        await clear_data();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      },
      onCancelBtnTap: (){
        Navigator.pop(context);
      }


      );


  }


  void storedata(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', data);
  }

  Future delete_item(int id) async {
    setState(() {
      isLoading = true;
    });
    Navigator.pop(context);
    
    // CHECKING IF INTERNET IS CONNECTED OR NOT
    bool check = await check_internet(context);
    if (check){return;}

    String url = "https://picalertapp-backend.herokuapp.com/api/area/create-area/";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    String item_id = id.toString();
    print(url+item_id);
    print(token);
    Response response =  await delete(
        Uri.parse(url+item_id+"/"),
        headers: {'Authorization': 'Token $token'},
    );
    
    await _handleRefresh();
    // Navigator.pop(context);
    

    MotionToast(
      icon:  Icons.delete_forever,
      title:  const Text("Deleted", ),
      description:  const Text("The item is deleted successfully"),
      width:  300,
	    height:  80, primaryColor: Colors.green,
      position: MotionToastPosition.top,
      animationType:  AnimationType.fromTop,
    ).show(context);
    


  }
  
  
}



    

Future clear_data() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.clear();
}