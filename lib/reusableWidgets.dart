import 'package:flutter/material.dart';
import 'courses.dart';
class ReusableWidgets{
  AppBar appBar(String text){
    return AppBar(
      title: Text(text),
      backgroundColor: Colors.black,
    ) ;
  }
}