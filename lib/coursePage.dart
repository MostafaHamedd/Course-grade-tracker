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
      appBar: AppBar(
        title: Text(widget.course.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromRGBO(0, 171, 179, 2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: courseContent(),
      ),
      floatingActionButton: myFloatingButton(),
      endDrawer: appDrawer(),
    );
  }

  Widget appDrawer() {
    return Drawer(
        child: ListView(children: [
      Container(
        height: 200,
        color: Colors.black,
      ),
      InkWell(
        child: ListTile(
            trailing: Icon(Icons.auto_graph),
            title: Text("Course progress  (Coming soon!)")),
        onTap: () {},
      ),
      InkWell(
        child: ListTile(
            trailing: Icon(Icons.add_circle),
            title: Text("Set target manually")),
        onTap: () {
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
                          backgroundColor: ReusableWidgets().getButtonsColor(),
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
                          backgroundColor: ReusableWidgets().getButtonsColor(),
                        )),
                  ],
                );
              });
        },
      ),
          InkWell(
            child: ListTile(
                trailing: Icon(Icons.mail_outlined),
                title: Text("Contact us")),
            onTap: () {},
          ),
    ]));
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
                title: Text("Add assesment"),
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
                    Text(
                      "Grade Needed",
                      style:
                          TextStyle(color: Colors.white70,fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    progressBar(),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ),
          ),
          assesmentContainer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                      targetGrade(),
                      targetSlider(),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget targetSlider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: ReusableWidgets().progressBarValueColor(),
        inactiveTrackColor: ReusableWidgets().progressBarBackgroundColor(),
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: 10.0,
        thumbColor: Colors.black,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
        overlayColor: Colors.indigo.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 12.0),
      ),
      child: Slider(
        value: widget.course.desiredGrade,
        min: 0,
        max: 100,
        divisions: null,
        label: widget.course.desiredGrade.toString(),
        onChanged: (double value) {
          calculated = true;
          widget.course.desiredGrade = value.roundToDouble();
          setState(() {});
        },
      ),
    );
  }

  Widget targetGrade() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text("Target Grade",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white70)),
          SizedBox(
            height: 10,
          ),
          Text(widget.course.getTargetGrade(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(
            height: 10,
          ),
        ],
      ),
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
              backgroundColor: ReusableWidgets().getButtonsColor(),
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
                              backgroundColor:
                                  ReusableWidgets().getButtonsColor(),
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
                              backgroundColor:
                                  ReusableWidgets().getButtonsColor(),
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
    if (widget.course.content.isNotEmpty) {
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
                  subtitle:
                      Text("Weight: " + assesment.weight.toString() + "%"),
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
                                    backgroundColor:
                                        ReusableWidgets().getButtonsColor(),
                                  )),
                              ElevatedButton(
                                  child: Text("Submit"),
                                  onPressed: () {
                                    if (assesment.isAttainable(
                                        double.parse(testGrade))) {
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
                                    backgroundColor:
                                        ReusableWidgets().getButtonsColor(),
                                  )),
                            ],
                          );
                        });
                  }),
            );
          },
        ),
      );
    } else {
      return Container(height:350,child: Center(child: Text("No assesments added", style: TextStyle(color: Colors.black, fontSize: 30)),),);
    }
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
