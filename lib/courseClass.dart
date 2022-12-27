
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'reusableWidgets.dart' ;
class Course {
  String name;
  List<Content> content ;

  Course(this.name, this.content){
    content = <Content>[] ;
  }

  void addAssesment(Content newContent){
    if(content==null){
      content = <Content>[] ;
      content.add(newContent)  ;
    }else{
      content.add(newContent)  ;

    }
  }
}

class Content {
   String name ;
   double weight ;
   List<String> elements;
   double grade;
   Content(this.name, this.weight,this.elements,this.grade){
     this.name = name ;
     this.weight = weight ;
     this.elements = elements ;
     this.grade = grade ;
   }


   double calculateWeightPerElement() {
     return weight / elements.length;
   }

   void addElements(int numElements) {
     for (int i = 1; i <= numElements; i++) {
       elements.add("$name $i");
     }
   }
}
