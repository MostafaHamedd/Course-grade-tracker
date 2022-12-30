import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:tellmore_course_tracker/courseClass.dart';
import 'reusableWidgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      backgroundColor: ReusableWidgets().getBackgroundColor(),
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
      backgroundColor: ReusableWidgets().getButtonsColor(),
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
                      primary: ReusableWidgets().getButtonsColor(),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: Text("Create"),
                    style: ElevatedButton.styleFrom(
                      primary: ReusableWidgets().getButtonsColor(),
                    ),
                    onPressed: () {
                      if (contentType.isNotEmpty &&
                          contentWeightController.text.isNotEmpty) {
                        if (widget.course.isFeaseable(
                            double.parse(contentWeightController.text))) {
                          widget.course.addAssesment(new Content(
                              contentType,
                              double.parse(contentWeightController.text),
                              [],
                              0,
                              false));
                          Navigator.of(context).pop();
                          setState(() {});
                        } else {
                          ReusableWidgets().showToast(
                              "Total assessment weight can't exceed 100%");
                        }
                      } else {
                        ReusableWidgets()
                            .showToast("Please fill all the fields");
                      }
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
          assesmentContainer(),
          targetGrade(),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.blue,
              inactiveTrackColor: Colors.blue,
              trackShape: RectangularSliderTrackShape(),
              trackHeight: 20.0,
              thumbColor: Colors.blueAccent,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            ),
            child: Slider(
              value:  widget.course.desiredGrade,
              min: 0,
              max: 100,
              divisions: 20,
              thumbColor: Colors.black,
              label:widget.course.desiredGrade.toString() ,
              onChanged: (double value) {
                calculated= true ;
                widget.course.desiredGrade= value ;
                setState(() {});
              },
            ),
          ),
          calculateButton(),
        ],
      ),
    );
  }

  Widget targetGrade() {
    return Row(
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

  Widget calculateButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
      child: Expanded(
        child: SizedBox(
          width: 120,
          height: 55,
          child: ElevatedButton(
            child: Text("Set a Target"),
            style: ElevatedButton.styleFrom(
              primary: ReusableWidgets().getButtonsColor(),
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
                          labelText: "Set target grade",
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
                              primary: ReusableWidgets().getButtonsColor(),
                            )),
                        ElevatedButton(
                            child: Text("Calculate"),
                            onPressed: () {
                              if (widget.course.isPossible(gradeEntered)) {
                                widget.course.desiredGrade = gradeEntered;
                                calculated = true;
                                Navigator.of(context).pop();
                                setState(() {});
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: ReusableWidgets().getButtonsColor(),
                            )),
                      ],
                    );
                  });
            },
          ),
        ),
      ),
    );
  }

  Widget assesmentContainer() {
    return Container(
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
                subtitle: Text("Weight: " + assesment.weight.toString() + "%"),
                trailing: Text("Grade: " + assesment.grade.toString() + "%"),
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
                                  primary: ReusableWidgets().getButtonsColor(),
                                )),
                            ElevatedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  if (assesment
                                      .isAttainable(double.parse(testGrade))) {
                                    assesment.grade = double.parse(testGrade);
                                    assesment.completed = true;
                                    setState(() {});
                                    Navigator.of(context).pop();
                                  } else {
                                    ReusableWidgets().showToast(
                                        "Grade has to be less than or equal assessment weight");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: ReusableWidgets().getButtonsColor(),
                                )),
                          ],
                        );
                      });
                }),
          );
        },
      ),
    );
  }

  Widget progressBar() {
    return Stack(
      children: [
        LinearProgressIndicator(
          value: widget.course.gradeNeeded(widget.course.desiredGrade) /
              100, // currentGrade is the current percentage of the grades, divided by 100 to convert it to a value between 0 and 1
          backgroundColor: ReusableWidgets().progressBarBackgroundColor(),

          valueColor:
              AlwaysStoppedAnimation(ReusableWidgets().progressBarValueColor()),
          minHeight: 30,
        ),
        Center(
          child: Text(getGrade(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        ),
      ],
    );
  }
}
