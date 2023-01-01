// ignore_for_file: unused_import, file_names, unnecessary_import, implementation_imports, use_build_context_synchronously, prefer_const_constructors, unused_local_variable, non_constant_identifier_names, sort_child_properties_last, no_leading_underscores_for_local_identifiers, duplicate_ignore, duplicate_import

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart';

import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:picalertapp/utils/sharedPreferences.dart';
import 'package:picalertapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'createArea/creatAreaUtils.dart';





class AddAreaItem extends StatefulWidget {
  const AddAreaItem({super.key});

  @override
  State<AddAreaItem> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddAreaItem> {
  DateTime _selectedDateStart = DateTime.now();
  DateTime _selectedDateEnd  = DateTime.now() ;
  DateTime? startDate;
  String? value;
  String token = '';


  String _selectedStatus = "Select";
  final TextEditingController _titleField = TextEditingController();
  final TextEditingController _description = TextEditingController();


  final repeatList = ['COMPLETED', 'NOT_STARTED'];



  bool _clicked = false;
  bool isAnimating = true;
  ButtonState state = ButtonState.init;
  // final width = MediaQuery.of(context).size.width;


  // String _titleFiled;
  @override
  Widget build(BuildContext context) {

  final width = MediaQuery.of(context).size.width;
  final isStretched = isAnimating || state == ButtonState.init;
  final isDone = state == ButtonState.done;
    return Scaffold(
    //  bottomNavigationBar:const bottomNavigationBar(),
      body: CustomScrollView(
          
          // semanticChildCount: data.length,
          slivers: [
            SliverAppBar.medium(
              leading:IconButton(icon: Icon(Icons.arrow_back), color: Colors.black, onPressed: ()=>Navigator.pop(context),),
              // toolbarHeight:100,
              backgroundColor: Colors.grey[100],
              title: const Text(
                'Create Area',
                style: TextStyle(fontSize: 25),
                ),
              actions: [
                IconButton(
                  onPressed:(){},
                  icon: const Icon(Icons.power_settings_new),
                  color: Colors.black,
                  )
                ],
              ),
            SliverFillRemaining(
              // decoration:,
              hasScrollBody: false,
              child:Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          CreateAreaFields(must: true ,title: "Title", hint: 'Title', controller: _titleField, ),
                          const SizedBox(height: 20,),
                          CreateAreaFields(isdesc:true, must: false ,title: "Description", hint: 'Description', controller: _description,),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              Expanded(
                                child: CreateAreaFields(
                                  startDateField: true,
                                  must: true ,
                                  title: "Start Date", 
                                  hint: DateFormat.yMd().format(_selectedDateStart),
                                  widget: IconButton(
                                    icon: const Icon(
                                      Icons.calendar_today_outlined,),
                                      iconSize: 22,
                                    color: Colors.grey[400],
                                    onPressed: () {
                                        _getDateFromUserStart();
                                      },
                                    ),
                                ),
                              ),
                              // const SizedBox(width: 1),
                              Expanded(
                                child: CreateAreaFields(
                                  selectedColor: (DateFormat.yMd().format(DateTime.now()) != DateFormat.yMd().format(_selectedDateEnd)) ? Colors.black: 
                                        Colors.grey ,
                                  startDateField: false,
                                  must: true ,
                                  title: "End Date", 
                                  hint: DateFormat.yMd().format(_selectedDateEnd),
                                  widget: IconButton(
                                    icon: const Icon(
                                      Icons.calendar_today_outlined,),
                                      iconSize: 22,
                                    color: Colors.grey[400],
                                    onPressed: () {
                                        _getDateFromUserend();
                                      },
                                    ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 30,),
                          
                          CreateAreaFields(
                              selectedColor:(_selectedStatus == "Select") ? Colors.grey :Colors.black,
                              must: true ,
                              title: "Status", 
                              hint: _selectedStatus,
                              widget: DropdownButton(
                                // value: value,
                                underline: Container(height: 0,color: Colors.black,),
                                icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[400], size:22,),
                                iconSize: 32,
                                elevation: 4,
                                style: subtitleStyle,
                                items: repeatList.map<DropdownMenuItem<String>>((String? value){
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value!, style: const TextStyle(color: Colors.grey)),
                                  );
                                }).toList(),
                                onChanged: (String? newValue){
                                  setState(() {
                                    _selectedStatus = newValue!;
                                  });
                                }
                                // onTap: setState(() => ),
                              )
                            ),
                            const SizedBox(height: 30,),
                          
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
                              width: (state == ButtonState.init) ? width: 70,
                              onEnd: () => setState(()=>isAnimating=!isAnimating),
                              child: isStretched ? buildButton() : progbar(isDone),


              )
            ),


                      // CreateAreaFields(must: true ,title: "Title", hint: 'Title',)

                    ],)),
                    
                  ]),
              ),
            // CreateAreaFields(title: "Title", hint: 'hint',)

          ]
        ),
    );
  }



  _getDateFromUserStart()async{
    DateTime? _pickerDatastart = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2010), 
      lastDate: DateTime((DateTime. now(). year)+1), 

    );

    if (_pickerDatastart != null){
      setState((){
        _selectedDateStart = _pickerDatastart;
        startDate = _pickerDatastart;
      });
      
    }else{

    }


  }

_getDateFromUserend()async{
    DateTime? _pickerDataend = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2010), 
      lastDate: DateTime((DateTime. now(). year)+1), 
    );
    if (startDate == null){
      MotionToast(
          icon:  Icons.error,
          title:  const Text("Start date not entered", style: TextStyle(fontWeight: FontWeight.bold),),
          description:  const Text("Please enter start date first"),
          width:  300,
          height:  80,
            primaryColor: Colors.red.shade200,
          position: MotionToastPosition.top,
          animationType:  AnimationType.fromTop,
          dismissable: false
        ).show(context);
        return;
    
    } 
    if (_pickerDataend != null){
      if (startDate!.isBefore(_pickerDataend)){
        setState(() => _selectedDateEnd = _pickerDataend);
        return;
      }else{
         MotionToast(
          
          icon:  Icons.error,
          title:  const Text("Date error", style: TextStyle(fontWeight: FontWeight.bold),),
          description:  const Text("End date cannot be before start date"),
          width:  300,
          height:  80,
            primaryColor: Colors.red.shade200,
          position: MotionToastPosition.top,
          animationType:  AnimationType.fromTop,
          dismissable: false
        ).show(context);
        return;
      }
       
    }else{


    }


  }


  


Widget progbar(isDone){
  final color = isDone?Colors.green : Colors.deepPurple;


  return Container(
    // height: 20,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    child: Center(
      child: isDone
      ?  Icon(Icons.done, size: 32, color:Colors.white):
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
      'Add Item',
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
      _validateData();
    }
    // setState(() => state = ButtonState.loading);
    // await Future.delayed(Duration(seconds: 3));
    // setState(() => state = ButtonState.done);
    // await Future.delayed(Duration(seconds: 3));
    // setState(() => state = ButtonState.init);

  }
);

_validateData() async {

  setState(() => state = ButtonState.loading);
  
  if (_titleField.text.isEmpty || _selectedStatus == "Select"){
     MotionToast(
      icon:  Icons.error_outline_rounded,
      title:  const Text("Please Enter the required fields", style: TextStyle(fontWeight: FontWeight.bold),),
      description:  const Text(""),
      width:  300,
      height:  80,
        primaryColor: Colors.red.shade200,
      position: MotionToastPosition.top,
      animationType:  AnimationType.fromTop,
    ).show(context);
    await Future.delayed(Duration(seconds: 1));
    setState(()=> _clicked = false );
    setState(() => state = ButtonState.init);
    await Future.delayed(Duration(seconds: 1));
    
    
  }else{
    
    // add call api

    Map<String,String> body = {
        "title": _titleField.text,
        "description": _description.text,
        "status": _selectedStatus
      };

    await _createAreaApiCall(body);
    


    
    
    // setState(() => state = ButtonState.done);
    await Future.delayed(Duration(milliseconds: 100));
    setState(()=> _clicked = false );
    
    // setState(() => state = ButtonState.init);
    await Future.delayed(Duration(seconds: 4));



    MotionToast(
      toastDuration: Duration(milliseconds: 1500),
      icon:  Icons.lock_outlined,
      title:  const Text("Item added Successfully", style: TextStyle(fontWeight: FontWeight.bold),),
      description:  const Text(""),
      width:  300,
      height:  80,
        primaryColor: Colors.green.shade200,
      position: MotionToastPosition.top,
      animationType:  AnimationType.fromTop,
      onClose: (){
        Navigator.pop(context);
      },
      dismissable: false
    ).show(context);
    setState(() => state = ButtonState.done);
    setState(() => state = ButtonState.init);
    
  }
  // Get.back();
  
  


  }


  Future _createAreaApiCall(Map<String,String> body) async {

      setState(() => state = ButtonState.loading);
      bool check = await check_internet(context);

      if (check){
        _clicked = false;
        setState(() => state = ButtonState.init);
        return;
      }
      
      String URL =  "https://picalertapp-backend.herokuapp.com/api/area/create-area/";
      token = UserSharedPreferences.getToken() ?? '';
      var response = await post(Uri.parse(URL),
          headers: {'Authorization': 'Token $token'},
          body: body ) ;
      print(response.body);
      // Response response =  await post(
      //   Uri.parse(URL),
      //   headers: {'Authorization': 'Token $token'},
      // );


  }
}

