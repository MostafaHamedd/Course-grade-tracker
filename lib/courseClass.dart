
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'reusableWidgets.dart' ;
class Course {
  String name;
  List<Content> content ;
  double desiredGrade ;

  Course(this.name, this.content,this.desiredGrade){
    content = <Content>[] ;
    this.desiredGrade = 0 ;

  }
  String getTargetGrade(){
    if(desiredGrade!=0){
      return desiredGrade.toString()+"%";
    }
    return "No Target grade set yet" ;
  }

  void addAssesment(Content newContent){
    if(content==null){
      content = <Content>[] ;
      content.add(newContent)  ;
    }else{
      content.add(newContent)  ;

    }
  }


  double gradeNeeded(double desiredGrade){
    print("$desiredGrade Testing");

    double scoreNeeded = 0 ;
    double totalEarned = 0;
    double totalWeight = 0;
    double gradeLeft = 0 ;
    if(content.length!=0){
      for(Content content in content){
        if(content.completed){
          totalWeight+=content.weight ;
          totalEarned+=content.grade ;
        }

      }
      gradeLeft = 100 - totalWeight ;
      scoreNeeded = (desiredGrade - totalEarned) ;

      scoreNeeded=scoreNeeded/gradeLeft ;
      scoreNeeded*=100 ;

      print("$scoreNeeded Testing output");
    }else{
      scoreNeeded = 0 ;

    }

    return scoreNeeded.round().toDouble() ;
  }
  String getScoreNeeded(double gradee){
    double grade = gradeNeeded(gradee) ;
    if(grade==0){
      return ""  ;
    }
    else if(grade<50){
      return "F ($grade)%"  ;
    }
    else if(grade >= 50 && grade < 60){
      return "D ($grade)%"  ;
    }
    else if(grade >= 50 && grade < 60){
      return "D ($grade)%"  ;
    }
    else if(grade >= 60 && grade < 65){
      return "C ($grade)%"  ;
    }
    else if(grade >= 65 && grade < 70){
      return "C+ ($grade)%"  ;
    }
    else if(grade >= 70 && grade < 75){
      return "B ($grade)%"  ;
    }
    else if(grade >= 75 && grade < 80){
      return "B+ ($grade)%"  ;
    }
    else if(grade >= 80 && grade < 90){
      return "A ($grade)%"  ;
    }
    else if(grade >= 90 && grade <= 100){
      return "A+ ($grade)%"  ;
    }
    else{
      return "Impossible to achieve :(" ;

    }
  }

  bool isPossible(double grade){
    return gradeNeeded(grade)<=100 ;
  }
}



class Content {
   String name ;
   double weight ;
   List<String> elements;
   double grade;
   bool completed ;
   Content(this.name, this.weight,this.elements,this.grade,this.completed){
     this.name = name ;
     this.weight = weight ;
     this.elements = elements ;
     this.grade = grade ;
     this.completed = false;

   }

   Icon getIcon(){
     if(completed)
       return Icon(Icons.done) ;

     return Icon(Icons.assignment) ;
   }


   bool isAttainable(){
     return grade <= weight ;
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
