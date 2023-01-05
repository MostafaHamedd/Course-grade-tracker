import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tellmore_course_tracker/coursePage.dart';
import 'courseClass.dart';
import 'coursePage.dart';
import 'dataBase.dart';
import 'reusableWidgets.dart' ;

import 'appData.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final List<Course> _courses = [];
  Course _newCourse = new Course("",[],0,false);
  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  void _loadCourses() async {
    Database? db = (await database().db)  ;
    final courses = await database().getCourses();
    setState(() {

      _courses.clear();
      _courses.addAll(courses);
     // for(Course course in _courses){
     //   print(course.name + " and " + course.desiredGrade.toString()) ;
     // }
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: myFloatingButton(),
       appBar: ReusableWidgets().appBar("Courses"),
      backgroundColor: ReusableWidgets().getBackgroundColor(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      child: Card(

                        color: Colors.black45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(alignment: Alignment.topLeft,child: Text(_courses[index].name, style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),)),
                                  Align(
                                    child: Icon(Icons.more_horiz),
                                    alignment: Alignment.topRight,
                                  ),
                                ],
                              ),

                              Divider(height: 10,),

                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Average:",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                            ),
                              Divider(height: 5,),

                              Stack(
                                children: [
                                  LinearProgressIndicator(
                                    value: (_courses[index].getAverageGrade() /
                                        100), // currentGrade is the current percentage of the grades, divided by 100 to convert it to a value between 0 and 1
                                    backgroundColor: ReusableWidgets().progressBarBackgroundColor(),

                                    valueColor:
                                    AlwaysStoppedAnimation(ReusableWidgets().progressBarValueColor()),
                                    minHeight: 30,
                                  ),

                                  Center(
                                    child: Text(_courses[index].getScore(_courses[index].getAverageGrade()),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40,)
                            ],
                          ),
                        ),
                      ),
                      onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => coursePage(
                                  course: _courses[index],

                                ) ));
                      },
                    ),
                    SizedBox(height: 20,)
                  ],
                );
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       labelText: "Add a new course",
          //     ),
          //     onChanged: (value) {
          //       _newCourse = Course(value, [],0);
          //     },
          //   ),
          // ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //   primary: ReusableWidgets().getButtonsColor()
          //   ),
          //
          //   child: Text("Add Course"),
          //   onPressed: () {
          //     setState(() {
          //       _courses.add(_newCourse);
          //     });
          //   },
          // ),
         // Divider(height: 50,)
        ],
      ),
    );
  }
  Widget myFloatingButton(){
    return FloatingActionButton(onPressed: (){
     showDialog(context: context, builder: (context){
       TextEditingController contentNameController = TextEditingController();
       Course newCourse = new Course("",[],0,false) ;
       return AlertDialog(

         title: Text("Add course"),
         content: Form(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               TextFormField(
                   controller: contentNameController,
                   decoration: InputDecoration(
                     labelText: "Course name",
                   ),
                 onChanged: (value){
                     newCourse.name = value.toString() ;
                 },
               ),
             ],

           ),

         ),
         actions: [
       ElevatedButton(
       child: Text("Cancel"),
       style: ElevatedButton.styleFrom(
       backgroundColor: ReusableWidgets().getButtonsColor(),
       ),
       onPressed: () {
       Navigator.of(context).pop();
       },
       ),
       ElevatedButton(
       child: Text("Create"),
       style: ElevatedButton.styleFrom(
       backgroundColor: ReusableWidgets().getButtonsColor(),

       ),
         onPressed: () async {

         if(newCourse.name.isNotEmpty){

           database().addCourse(newCourse);
           _courses.add(newCourse) ;
           Navigator.pop(context) ;
           setState(() {

           });
         }
         },
       ),

         ],
       );
     }) ;
    },child: Icon(Icons.add),backgroundColor: ReusableWidgets().getButtonsColor(),);
  }
}
