import 'package:flutter/material.dart';
import 'courses.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReusableWidgets{
  AppBar appBar(String text){
    return AppBar(
      title: Text(text),
      backgroundColor: Color.fromRGBO(0, 171, 179, 2) ,
    ) ;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  Color getBackgroundColor(){
    return Color.fromRGBO(178, 178, 178, 2) ;

  }
  Color getButtonsColor(){
    return  Color.fromRGBO(60, 64, 62, 2) ;
  }
  Color progressBarBackgroundColor() {
    return Color.fromRGBO(200, 200, 200, 2);
   }
    Color progressBarValueColor(){
       return Color.fromRGBO(0, 171, 179, 2) ;
      // return Colors.blueAccent;
    }
}