import 'package:flutter/material.dart';
import 'courses.dart';
import 'package:page_transition/page_transition.dart';
import 'reusableWidgets.dart' ;
import 'package:slider_button/slider_button.dart';
import 'dataBase.dart' ;

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
      body:features(),
    );
  }

  Widget features(){
    int  currPage =0 ;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          PageView(
            children: [
              Card(
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    // Image.asset(),
                    Text("Feature 1"),
                    Text("Description of Feature 1"),
                  ],
                ),
              ),
              Card(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    //Image.asset("feature2.jpg"),
                    Text("Feature 2"),
                    Text("Description of Feature 2"),
                  ],
                ),
              ),
              Card(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          //Image.asset("feature3.jpg"),
                          Text("Feature 3"),
                          Text("Description of Feature 3"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                       child:ElevatedButton(
    onPressed: () {


    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: CoursesPage(),alignment: Alignment.center));
    },
    child: const Text('Get Started'),
    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.black),
    ),
    ),
    //Align(alignment: Alignment.bottomCenter,child:SliderButton(
                      //
                      //     buttonColor: Colors.black38,
                      //     backgroundColor: Colors.black12,
                      //     action: () {
                      //       ///Do something here
                      //       Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: CoursesPage(),alignment: Alignment.center));
                      //     },
                      //     label: Text(
                      //       "Get Started!       ",
                      //       style: TextStyle(
                      //           color: Color(0xff4a4a4a), fontWeight: FontWeight.w500, fontSize: 17),
                      //     ),
                      //     icon: Icon(Icons.navigate_next,size: 50,)
                      //
                      //
                      // )
                   //   ),
                    )
                  ],
                ),
              ),
            ],
            onPageChanged: (int index) {
              setState(() {
                currPage = index ;
              });
            },
          ),

        ],

      ),
    );
    // ),

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

