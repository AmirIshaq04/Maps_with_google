import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class commonWidgets{
  static CustomTextField(TextEditingController controller,String text,IconData iconData,bool toHide){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        decoration: InputDecoration(isDense: true,
            hintText: text,
            suffixIcon: Icon(iconData),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )
        ),
      ),
    );
  }
  static CustomButton(VoidCallback voidCallback,String text){
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        onPressed: ()
        {
          voidCallback();
        },style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(),backgroundColor: Colors.blue), child: Text(text,style: TextStyle(color: Colors.white,fontSize: 15,),),),
    );
  }
  static CustomeBox(BuildContext context,String text){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Ok')),
        ],
      );
    },);
  }
}