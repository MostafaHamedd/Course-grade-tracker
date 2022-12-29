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
  bool calculated = false;
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
                          controller: contentWeightController,
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
                              contentType = value.toString();
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
                      widget.course.addAssesment(new Content(
                          contentType,
                          double.parse(contentWeightController.text),
                          [],
                          0,
                          false));
                      print(widget.course.content.length);
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  ),
                ],
              );
            });
      },
    );
  }

  String getGrade() {
    if (!calculated) {
      return "";
    }
    return widget.course.getScoreNeeded(widget.course.desiredGrade).toString();
  }

  Widget courseContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Grade Needed: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
            ),
          ),
          progressBar(),
          Text(getGrade(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),


          assesmentContainer(),

          targetGrade(),
          calculateButton(),
        ],
      ),
    );
  }

  Widget targetGrade(){
    return  Row(
      children: [
        SizedBox(
          height: 50,
        ),
        Text("Target Grade: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(
          width: 10,
        ),
        Text(widget.course.getTargetGrade(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ],
    );
  }
  Widget calculateButton(){
    return   Padding(
      padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
      child: Expanded(
        child: SizedBox(
          width: 120,
          height: 55,
          child: ElevatedButton(
            child: Text("Calculate"),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    TextEditingController gradeEnteredController =
                    TextEditingController();
                    double gradeEntered = 0;
                    return AlertDialog(
                      title: Text("Calculate"),
                      content: TextField(
                        controller: gradeEnteredController,
                        decoration: InputDecoration(
                          labelText: "Enter desired grade",
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            gradeEntered =
                                double.parse(gradeEnteredController.text);
                          });
                        },
                      ),
                      actions: [
                        ElevatedButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                            )),
                        ElevatedButton(
                            child: Text("Calculate"),
                            onPressed: () {
                              print(gradeEntered);
                              if (widget.course
                                  .isPossible(gradeEntered)) {
                                widget.course.desiredGrade = gradeEntered;
                                calculated = true;
                                Navigator.of(context).pop();
                                setState(() {});
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                            )),
                      ],
                    );
                  });
            },
          ),
        ),
      ),
    ) ;
  }
  Widget assesmentContainer(){
    return  Container(
      height: 350,
      child: ListView.builder(
        itemCount: widget.course.content.length,
        itemBuilder: (context, index) {
          Content assesment = widget.course.content[index];
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: UniqueKey(),
            // specify a unique key for the Dismissible widget
            background: Container(
              color: Colors.green,
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ), // specify the background color when swiping
            secondaryBackground: Container(
                color: Colors.red,
                child: Center(
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ))), // specify the secondary background color (e.g. for an undo action)
            onDismissed: (direction) {
              widget.course.content.remove(assesment);
              setState(() {});

            },
            child: ListTile(
                leading: assesment.getIcon(),
                title: Text(assesment.name),
                subtitle:
                Text("Weight: " + assesment.weight.toString() + "%"),
                trailing:
                Text("Grade: " + assesment.grade.toString() + "%"),
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
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                )),
                            ElevatedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  assesment.grade =
                                      double.parse(testGrade);
                                  if (assesment.isAttainable()) {
                                    assesment.completed = true;
                                    setState(() {});
                                    Navigator.of(context).pop();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                )),
                          ],
                        );
                      });
                }),
          );
        },
      ),
    ) ;
  }
  Widget progressBar(){
    return           LinearProgressIndicator(
      value: widget.course.gradeNeeded(widget.course.desiredGrade) /
          100, // currentGrade is the current percentage of the grades, divided by 100 to convert it to a value between 0 and 1
      backgroundColor: Colors.grey[200],
      valueColor: AlwaysStoppedAnimation(Colors.blue),
    ) ;

  }
}
