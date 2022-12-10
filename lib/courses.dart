import 'package:flutter/material.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final List<String> _courses = ["Course 1", "Course 2", "Course 3"];
  String _newCourse = "";

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
                    title: Text(_courses[index]),
                    onTap: () {
                      // Do something when the tile is clicked
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //     builder: (context) => AddAssignmentsScreen(course: _courses[index]));
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _courses.add(_newCourse);
                        _newCourse = "";
                        // Do something when the button is clicked
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
                _newCourse = value;
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

