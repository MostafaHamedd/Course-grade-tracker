import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' ;

import 'courseClass.dart';

class contentDatabase{
  static Database? _contentDb ;

  Future<Database?> get db async {
    print("get Content CALLED");
    if(_contentDb==null){
      print("CALLING Content INIT") ;
      _contentDb = await initDatabase() ;
      return _contentDb ;
    }else{
      print("Content DATABASE ALREADYY CREATEDDD") ;
      return _contentDb ;
    }

  }




  initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "Test2DB.db");
    Database mydb = await openDatabase(path, version: 1,onCreate: _oncreate) ;
    return mydb;
  }

  _oncreate(Database db,int version) async{
    print("DATABASE Content CREATEDDD") ;
    await db.execute("CREATE TABLE contents(name TEXT , courseName TEXT,weight double,grade double,isCompleted INTEGER,PRIMARY KEY (name, courseName))")
    ;

  }


  Future<void> addContent(Course course,Content newContent) async{
    String courseName = course.name ;
    String contentName = newContent.name ;
    double contentWeight = newContent.weight ;
    double contentGrade = newContent.grade ;
    int isContentCompleted = 0 ;
    if(newContent.completed){
      isContentCompleted =  1 ;
    }
    if ( _contentDb  == null) {
      throw Exception("Field 'db' has not been initialized. Content");
    }
    _contentDb ?.execute("INSERT INTO contents(name, courseName,weight,grade,isCompleted) VALUES ('$contentName','$courseName',$contentWeight,$contentGrade,$isContentCompleted)") ;
    print("Content $contentName added");
  }

  Future<void> getData() async{
    if ( _contentDb  == null) {
      throw Exception("Field 'db' has not been initialized. Content");
    }
    List<Map<String, dynamic>>? rows = await _contentDb?.query("contents");
    print(rows);
    if (rows != null) {
      for (var row in rows) {
        print(row['desiredGrade'].toString()+ " thats the name");
      }
    }
  }

  Future<List<Content>> getContents(Course course) async{
    String courseName = course.name ;
    if ( _contentDb  == null) {
      throw Exception("Field 'db' has not been initialized. Content");
    }
    List<Map<String, dynamic>>? rows = await _contentDb?.query("contents WHERE courseName = '$courseName'");
   // print(rows);
    List<Content> contents = [] ;
    if (rows != null) {
      for (var row in rows) {
    //    print(test==1) ;
    //   print(  "name: "+ row['name'] + " weight: "+ row['weight'].toString() +" $test + here" );
       contents.add(new Content(row['name'],row['weight'],[],row['grade'], row['isCompleted']==1)) ;

      }
    }

    return contents ;
  }
  // Future<void> updateDesiredGrade(String courseName, double desiredGrade) async {
  //   if (_contentDb == null) {
  //     throw Exception("Field 'db' has not been initialized.");
  //   }
  //   await _contentDb?.rawUpdate(
  //       "UPDATE courses SET desiredGrade = ? WHERE name = ?",
  //       [desiredGrade, courseName]);
  // }
  Future<void> deleteContent(Course course,Content content) async {
    // Get the course name of the content
    String courseName = course.name;
    // Get the name of the content
    String contentName = content.name;
    // Check if the content database has been initialized
    if (_contentDb == null) {
      throw Exception("Field 'db' has not been initialized. Content");
    }
    // Delete the content from the database
    await _contentDb?.delete("contents", where: "courseName = ? AND name = ?", whereArgs: [courseName, contentName]);
  }
  Future<void> updateContent(Course course,Content newContent) async {
    String courseName = course.name;
    // Get the name of the content
    String contentName = newContent.name;

    int isContentCompleted = 0 ;
    if(newContent.completed){
      isContentCompleted =  1 ;
    }
    if (_contentDb == null) {
      throw Exception("Field 'db' has not been initialized.");
    }
    await _contentDb?.rawUpdate(
        "UPDATE contents SET weight = ?,grade = ?, isCompleted = ?  WHERE name = ?",
        [newContent.weight,newContent.grade,isContentCompleted, contentName]);
    print("UPDATED Contents") ;
    //getContents(new Course('Comp3190',[],0),);
  }
}



