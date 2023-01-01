// ignore_for_file: must_be_immutable, implementation_imports, unnecessary_import, unused_field, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAreaFields extends StatelessWidget {
  final bool must;
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final bool? isdesc;
  final bool? startDateField;
  final bool? EndDateField;
  final Color? selectedColor;
  // final isStatus;


  const CreateAreaFields({Key? key,
    required this.must,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    this.isdesc,
    this.startDateField,
    this.EndDateField,
    this.selectedColor,
    // this.isStatus,

    }): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: (startDateField == null && EndDateField == null) ? const EdgeInsets.symmetric(horizontal: 25.0) 
                  : (startDateField == true) ? const EdgeInsets.only(left: 25, right: 5) 
                  : const EdgeInsets.only(right: 25, left: 5),

          child: TextFormField(
            
            readOnly: (widget == null) ? false : true,
            keyboardType: (isdesc == true) ? TextInputType.multiline : null,
            maxLength: (isdesc == true) ? 100 : null,
            // conten: (isdesc == true) ? 90 : 52,
            // enabled: (state == ButtonState.loading) ? false : true,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: (widget != null) ? widget : null,
              
              // (must == true) ? const Text(" *", style: TextStyle(color: Colors.red),) : Text(" (Optional)", style: TextStyle(color: Colors.grey[600])),
              fillColor: Colors.grey[200],
              filled: true,
              hintText: hint,
              // (startDateField != null || EndDateField != null)
              hintStyle: (widget != null) ? TextStyle(
                color: (selectedColor == null) ? Colors.grey : selectedColor,
                fontSize: 13, 
                )
                          : const  TextStyle(color: Colors.grey),

              labelText: (must == true) ? title+" *" : title + " (Optional)",
              labelStyle: TextStyle(color: Colors.deepPurple[800]),
              floatingLabelBehavior: (widget == null) ? FloatingLabelBehavior.auto : FloatingLabelBehavior.always,
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
            maxLines: (isdesc == true) ? 5 : null,
            
            
          ),
          
        ),
                  
    );
  }
}


TextStyle get subtitleStyle{
  return  GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color:Colors.grey.shade600,

    ),
  );
}


TextStyle get titleStyle{
  return  GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color:Colors.black,

    ),
  );
}




// class dateInputField extends StatefulWidget {
//   const dateInputField({super.key});

//   @override
//   State<dateInputField> createState() => _dateInputFieldState();
// }

// class _dateInputFieldState extends State<dateInputField> {
//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children:[
//               Text(
//                 title,
//                 style: titleStyle,
//               ),
//               (must == true) ? const Text(" *", style: TextStyle(color: Colors.red),) : Text(" (Optional)", style: TextStyle(color: Colors.grey[600])),
              
//             ],
//           ),
//           Container(
//             height: (isdesc == true) ? 90 : 52,
//             margin: const EdgeInsets.only(top:8.0),
//             padding: const EdgeInsets.only(left: 14),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.grey,
//                 width: 1.0

//               ),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children:[
//                 Expanded(
//                   child: TextFormField(
                    
//                     maxLength:(isdesc == true) ? 100:null,
//                     minLines: 1,
//                     maxLines: (isdesc == true) ? 6 : 1,
//                     keyboardType: (isdesc == true) ? TextInputType.multiline : null,
//                     readOnly: (widget == null) ? false : true,
//                     autofocus: true ,
//                     controller: controller,
//                     style: subtitleStyle,
//                     decoration: InputDecoration(
//                       labelText:"title",
//                       hintText: hint,
//                       hintStyle: subtitleStyle,

//                       // focusedBorder: const UnderlineInputBorder(
//                       //   borderSide: BorderSide(
//                       //     color: Colors.white,
//                       //     width: 0
//                       //   )
//                       // ),
//                       // enabledBorder: const UnderlineInputBorder(
//                       //   borderSide: BorderSide(
//                       //     color: Colors.white,
//                       //     width: 0
//                       //   )
//                       // )
//                     )
//                   ),
//                 ),
              
//                 (widget == null)?Container():Container(child: widget,)
//             ]
//           )
//           )
//         ]
//       ),
//     );

//   }

// }

