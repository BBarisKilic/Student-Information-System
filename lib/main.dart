import 'package:flutter/material.dart';
import 'package:student_information_system/screens/student_add.dart';
import 'package:student_information_system/screens/student_update.dart';
import 'models/student.dart';

void main() {
  runApp(StudentInformationSystem());
}

class StudentInformationSystem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State {
  List<Student> students = [
    Student.withId(1, "Barış", "K", 75),
    Student.withId(2, "Öznur", "G", 75),
    Student.withId(3, "Ulaş", "K", 44),
  ];

  Student selectedStudent = Student.withId(0, "Non", "", 0);
  Color updateColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Information System"),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: updateColor,
                  title: Text(
                    students[index].firstName + " " + students[index].lastName,
                  ),
                  subtitle: Text(
                    "The grade the student received: " +
                        students[index].grade.toString(),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://png.pngtree.com/png-vector/20190118/ourlarge/pngtree-vector-male-student-icon-png-image_326762.jpg"),
                  ),
                  trailing: buildIconStatus(students[index].getStatus),
                  onTap: () {
                    setState(() {
                      selectedStudent = students[index];
                    });
                    if (updateColor == Colors.amberAccent) {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentUpdate(
                                      students, selectedStudent, index)))
                          .then((value) => setState(() {}));
                      updateColor = Colors.transparent;
                    } else if (updateColor == Colors.redAccent) {
                      showAlertDeleteStudent(context, index);
                    }
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 4,
                );
              },
            ),
          ),
          Text(
            bottomInfoText(),
          ),
          Row(
            children: <Widget>[
              manuelBottomBar(
                  1, "New Student", 6, Colors.greenAccent, Icon(Icons.add)),
              manuelBottomBar(
                  2, "Edit", 4, Colors.amberAccent, Icon(Icons.update)),
              manuelBottomBar(
                  3, "Delete", 5, Colors.redAccent, Icon(Icons.delete)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildIconStatus(bool status) {
    if (status == true) {
      return Icon(Icons.done);
    } else {
      return Icon(Icons.clear);
    }
  }

  Widget manuelBottomBar(
      int buttonId, String info, int flex, Color color, Icon icon) {
    return Flexible(
      fit: FlexFit.loose,
      flex: flex,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        child: Row(
          children: <Widget>[
            icon,
            SizedBox(
              width: 5.0,
            ),
            Text(info)
          ],
        ),
        onPressed: () {
          if (buttonId == 1) {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentAdd(students)))
                .then((value) => setState(() {
                      updateColor = Colors.transparent;
                    }));
          } else if (buttonId == 2) {
            setState(() {
              if (updateColor == Colors.amberAccent) {
                updateColor = Colors.transparent;
              } else {
                updateColor = Colors.amberAccent;
              }
            });
            //Navigator.push(context,
            //        MaterialPageRoute(builder: (context) => StudentUpdate()))
            //    .then((value) => setState(() {}));
          } else {
            setState(() {
              if (updateColor == Colors.redAccent) {
                updateColor = Colors.transparent;
              } else {
                updateColor = Colors.redAccent;
              }
            });
          }
        },
      ),
    );
  }

  String bottomInfoText() {
    if (updateColor == Colors.amberAccent) {
      return "Select the student you want to edit!";
    } else if (updateColor == Colors.redAccent) {
      return "Select the student you want to delete!";
    } else {
      if (selectedStudent.grade >= 50) {
        return selectedStudent.firstName + ": " + "Passed";
      } else {
        return selectedStudent.firstName + ": " "Failed";
      }
    }
  }

  void showAlertDeleteStudent(BuildContext context, int index) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        setState(() {
          updateColor = Colors.transparent;
        });
        Navigator.pop(context);
      },
    );

    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        setState(() {
          updateColor = Colors.transparent;
          students.removeAt(index);
        });
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Caution!"),
      content: Text("If you continue, the selected '" +
          students[index].firstName +
          "' student's data will be completely deleted!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
