import 'package:flutter/material.dart';
import 'package:ogrenci_bilgi_sistemi/models/student.dart';

class StudentUpdate extends StatefulWidget {
  List<Student> students;
  Student selectedStudent = Student.withId(0, "Hiç kimse", "", 0);
  int index;
  StudentUpdate(this.students, this.selectedStudent, this.index);

  @override
  State<StatefulWidget> createState() {
    return _StudentUpdate();
  }
}

class _StudentUpdate extends State<StudentUpdate> {
  var formKey = GlobalKey<FormState>();
  Student changedStudent = Student("", "", 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Bilgilerini Düzenle"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                buildFirstNameText(),
                buildLastNameText(),
                buildGradeText(),
                buildReturnButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFirstNameText() {
    return TextFormField(
      initialValue: widget.selectedStudent.firstName,
      decoration: InputDecoration(labelText: "Öğrenci adı:"),
      onSaved: (String value) {
        changedStudent.firstName = value;
      },
    );
  }

  Widget buildLastNameText() {
    return TextFormField(
      initialValue: widget.selectedStudent.lastName,
      decoration: InputDecoration(labelText: "Öğrenci soyadı:"),
      onSaved: (String value) {
        changedStudent.lastName = value;
      },
    );
  }

  Widget buildGradeText() {
    return TextFormField(
      initialValue: widget.selectedStudent.grade.toString(),
      decoration: InputDecoration(labelText: "Öğrenci'nin aldığı not:"),
      onSaved: (String value) {
        changedStudent.grade = int.parse(value);
      },
    );
  }

  Widget buildReturnButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: () {
        formKey.currentState.save();
        widget.students[widget.index] = changedStudent;
        Navigator.pop(context);
      },
    );
  }
}
