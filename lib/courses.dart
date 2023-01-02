import 'package:flutter/material.dart';
import 'package:tellmore_course_tracker/coursePage.dart';
import 'courseClass.dart';
import 'coursePage.dart';
import 'reusableWidgets.dart' ;

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final List<Course> _courses = [    Course("Course 1", [],0),
    Course("Course 2", [],0),
    Course("Course 3", [],0)
  ];
  Course _newCourse = new Course("",[],0);

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
                return Container(
                  color: Colors.primaries[index % Colors.primaries.length],
                  child: ListTile(
                    title: Text(_courses[index].name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => coursePage(
                            course: new Course(_courses[index].name,<Content>[],0),

                          ),
                        ),
                      );

                    },
                    trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _courses.add(_newCourse);
                        _newCourse = new Course("",[],0);
                      },
                    ),
                  ),
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
        ],
      ),
    );
  }
  Widget myFloatingButton(){
    return FloatingActionButton(onPressed: (){
     showDialog(context: context, builder: (context){
       TextEditingController contentNameController = TextEditingController();
       Course newCourse = new Course("",[],0) ;
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
         onPressed: (){
         if(newCourse.name.isNotEmpty){
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
