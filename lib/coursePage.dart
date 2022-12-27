import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:tellmore_course_tracker/courseClass.dart';
import 'reusableWidgets.dart';

class coursePage extends StatefulWidget {
  const coursePage({
    Key? key,
    // required this.courseName,
    // required this.courseContent,
    required this.course,
  }) : super(key: key);
  // final String courseName; // Declare a field to store the course name
  // final List<Content> courseContent; // Declare a field to store the course content
  final Course course;
  @override
  State<coursePage> createState() => _coursePageState();
}

class _coursePageState extends State<coursePage> {
  String testGrade = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets().appBar(widget.course.name),
      body: courseContent(),
      floatingActionButton: myFloatingButton(),
    );
  }

  Widget myFloatingButton() {
    String contentName = '';
    String contentWeight = '';
    String contentType = '';
    TextEditingController contentWeightController = TextEditingController();

    return FloatingActionButton(
      backgroundColor: Colors.black,
      child: Icon(Icons.add, color: Colors.white),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add Content"),
                //key: ,
                content: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // TextFormField(
                      //     // controller: ,
                      //     decoration: InputDecoration(
                      //   labelText: "Name",
                      // )),
                      TextFormField(
                           controller:contentWeightController ,
                          decoration: InputDecoration(
                        labelText: "Weight (in %)",
                      )),
                      DropdownButtonFormField(

                          // value: contentType,
                          decoration: InputDecoration(
                            labelText: "Type",
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text("Assignment"),
                              value: "Assignment",
                            ),
                            DropdownMenuItem(
                              child: Text("Quizzes"),
                              value: "Quizzes",
                            ),
                            DropdownMenuItem(
                              child: Text("Midterm"),
                              value: "Midterm",
                            ),
                            DropdownMenuItem(
                              child: Text("Project"),
                              value: "Project",
                            ),
                            DropdownMenuItem(
                              child: Text("Final"),
                              value: "Final",
                            ),
                            DropdownMenuItem(
                              child: Text("Test"),
                              value: "Tests",
                            ),
                            DropdownMenuItem(
                              child: Text("Labs"),
                              value: "Labs",
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              contentType = value.toString() ;
                              //      _selectedType = value;
                            });
                          })
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    child: Text("Cancel"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {

                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: Text("Submit"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      print(contentWeightController.text);
                      widget.course.addAssesment(new Content(contentType,double.parse(contentWeightController.text),[],0)) ;
                      print(widget.course.content.length);
                      Navigator.of(context).pop();
                      setState(() {

                      });
                    },
                  ),
                ],
              );
            });
      },
    );
  }

  Widget courseContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 25, 250, 0),
          child: Container(
            child: Text(
              "Current Grade: ",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Container(
          height : 300 ,
          child: ListView.builder(

            itemCount: widget.course.content.length,
            itemBuilder: (context, index) {
              Content assesment =  widget.course.content[index] ;
              return ListTile(
                  leading: Icon(Icons.assignment),
                  title: Text(assesment.name),
                  subtitle: Text("Weight: " +assesment.weight.toString()+"%"),
                  trailing: Text("Grade: " +assesment.grade.toString() + "%"),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Grade Earned"),

                            content: TextField(
                              decoration: InputDecoration(
                                labelText: "Enter grade awarded",
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {

                                  testGrade = value;
                                  print("Here");
                                  print(widget.course.content.length);
                                });
                              },
                            ),
                            actions: [
                              ElevatedButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ElevatedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  assesment.grade = double.parse(testGrade) ;
                                  setState(() {

                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  });
            },
          ),
        ),
      ],
    );
  }
}
