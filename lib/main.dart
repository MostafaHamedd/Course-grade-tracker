import 'package:flutter/material.dart';
import 'courses.dart';
import 'package:page_transition/page_transition.dart';
import 'reusableWidgets.dart' ;

void main() {
  runApp(
  MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grade Tracker',
      home: new pageScaffold() ,
      debugShowCheckedModeBanner: false,
    );
  }
}
class pageScaffold extends StatefulWidget {
  const pageScaffold({Key? key}) : super(key: key);

  @override
  State<pageScaffold> createState() => _pageScaffoldState();
}

class _pageScaffoldState extends State<pageScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReusableWidgets().getBackgroundColor(),
      appBar: ReusableWidgets().appBar("Tellmore's Grade tracker") ,
      body: homePageBody(context),
    );
  }
}

Widget homePageBody(BuildContext context) {
  return Center(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Container(
              child: Text(
            "Welcome",
            style: TextStyle(fontSize: 40),
          )),
        ),
        SizedBox(
          height: 250,
        ),
        SizedBox(
          width: 200,
          height: 80,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: CoursesPage(),alignment: Alignment.center));
            },
            child: const Text('Get Started'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}
