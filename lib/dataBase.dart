import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' ;

import 'courseClass.dart';

class database{
static Database? _db ;

Future<Database?> get db async {
  print("get CALLED");
  if(_db==null){
    print("CALLING INIT") ;
    _db = await initDatabase() ;
    return _db ;
  }else{
    print("DATABASE ALREADYY CREATEDDD") ;
    return _db ;
  }

}




  initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "TestDB.db");
 Database mydb = await openDatabase(path, version: 1,onCreate: _oncreate) ;
return mydb;
  }

  _oncreate(Database db,int version) async{
    print("DATABASE CREATEDDD") ;
    await db.execute("CREATE TABLE courses(name TEXT PRIMARY KEY, desiredGrade DOUBLE, isCalculated INTEGER)")
    ;

  }


 Future<void> addCourse(Course newCourse) async{
  String courseName = newCourse.name ;
  double desiredGrade = newCourse.desiredGrade ;
  int isCalculated = newCourse.isCalculated ? 1: 0;
   if ( _db  == null) {
     throw Exception("Field 'db' has not been initialized.");
   }
   _db ?.execute("INSERT INTO courses(name, desiredGrade,isCalculated) VALUES ('$courseName', 0,$isCalculated)") ;
   print("$courseName added");
  }

  Future<void> getData() async{
    if ( _db  == null) {
      throw Exception("Field 'db' has not been initialized.");
    }
    List<Map<String, dynamic>>? rows = await _db?.query("courses");
    print(rows);
    if (rows != null) {
      for (var row in rows) {
      //  print(row['desiredGrade'].toString()+ " thats the name");
      }
    }
  }

Future<List<Course>> getCourses() async{
  if ( _db  == null) {
    throw Exception("Field 'db' has not been initialized.");
  }
  List<Map<String, dynamic>>? rows = await _db?.query("courses");
  print(rows);
  List<Course> courses = [] ;
  if (rows != null) {
    for (var row in rows) {
      //print(  "name:"+ row['name'].toString()  + " desired grade: "+ row['desiredGrade'].toString() );
      courses.add(new Course(row['name'],[],row['desiredGrade'],row['isCalculated']==1)) ;

    }
  }

  return courses ;
}
Future<void> updateDesiredGrade(String courseName, double desiredGrade,bool isCalculated) async {
  if (_db == null) {
    throw Exception("Field 'db' has not been initialized.");
  }
  await _db?.rawUpdate(
      "UPDATE courses SET desiredGrade = ? , isCalculated = ? WHERE name = ?",
      [desiredGrade, isCalculated? 1: 0,courseName]);
}

Future<void> deleteCourse(String courseName) async {
  if (_db == null) {
    throw Exception("Field 'db' has not been initialized.");
  }
  await _db?.rawDelete(
      "DELETE FROM courses WHERE name = ?",
      [courseName]);

  print("deleted course") ;
}

}



