import 'package:flutter/material.dart';
import 'package:tellmore_course_tracker/coursePage.dart';
import 'courseClass.dart';
import 'coursePage.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final List<Course> _courses = [    Course("Course 1", []),
    Course("Course 2", []),
    Course("Course 3", [])
  ];
  Course _newCourse = new Course("",[]);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
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
                            course: new Course(_courses[index].name,<Content>[]),

                          ),
                        ),
                      );
                      print("Button presed");
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _courses.add(_newCourse);
                        _newCourse = new Course("",[]);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Add a new course",
              ),
              onChanged: (value) {
                _newCourse = Course(value, []);
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              // Set the button color to black
            ),
            child: Text("Add Course"),
            onPressed: () {
              setState(() {
                _courses.add(_newCourse);
              });
            },
          ),
        ],
      ),
    );
  }
}
