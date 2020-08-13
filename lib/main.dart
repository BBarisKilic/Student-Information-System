import 'package:flutter/material.dart';
import 'package:ogrenci_bilgi_sistemi/screens/student_add.dart';
import 'package:ogrenci_bilgi_sistemi/screens/student_update.dart';
import 'models/student.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
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

  Student selectedStudent = Student.withId(0, "Hiç kimse", "", 0);
  Color updateColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Bilgi Sistemi"),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    students[index].firstName + " " + students[index].lastName,
                    style: TextStyle(backgroundColor: updateColor),
                  ),
                  subtitle: Text(
                    "Öğrencinin aldığı not: " +
                        students[index].grade.toString(),
                    style: TextStyle(backgroundColor: updateColor),
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
              }),
        ),
        Text(
          bottomInfoText(),
        ),
        Row(
          children: <Widget>[
            manuelBottomBar(
                1, "Yeni Öğrenci", 4, Colors.greenAccent, Icon(Icons.add)),
            manuelBottomBar(
                2, "Düzenle", 3, Colors.amberAccent, Icon(Icons.update)),
            manuelBottomBar(3, "Sil", 2, Colors.redAccent, Icon(Icons.delete)),
          ],
        )
      ],
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
      child: RaisedButton(
        color: color,
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
      return "Düzenlemek istediğiniz öğrenciyi seçiniz!";
    } else if (updateColor == Colors.redAccent) {
      return "Silmek istediğiniz öğrenciyi seçiniz!";
    } else {
      if (selectedStudent.grade >= 50) {
        return selectedStudent.firstName + ": " + "Geçti";
      } else {
        return selectedStudent.firstName + ": " "Kaldı";
      }
    }
  }

  void showAlertDeleteStudent(BuildContext context, int index) {
    Widget cancelButton = FlatButton(
      child: Text("İptal"),
      onPressed: () {
        setState(() {
          updateColor = Colors.transparent;
        });
        Navigator.pop(context);
      },
    );

    Widget continueButton = FlatButton(
      child: Text("Devam et"),
      onPressed: () {
        setState(() {
          updateColor = Colors.transparent;
          students.removeAt(index);
        });
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Dikkat!"),
      content: Text("Devam etmeniz durumunda seçili öğrencinin '" +
          students[index].firstName +
          "' verileri tamamen silinecek!"),
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
