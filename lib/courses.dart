import 'package:flutter/material.dart';
import 'package:tellmore_course_tracker/reusableWidgets.dart';
import 'reusableWidgets.dart';
class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets().appBar('My Courses'),
      body: coursesBody(),
    );
  }
}

Widget coursesBody(){
  return Center(
    child: Column(
      children: [
        Container(
          child: Text('Course 1'),
        ),
      ],
    ),
  );
}
