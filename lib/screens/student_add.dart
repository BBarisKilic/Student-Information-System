import 'package:flutter/material.dart';
import 'package:ogrenci_bilgi_sistemi/models/student.dart';
import 'package:ogrenci_bilgi_sistemi/validation/text_validation.dart';

class StudentAdd extends StatefulWidget {
  List<Student> students;
  StudentAdd(this.students);
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState();
  }
}

class _StudentAddState extends State<StudentAdd> with textValidationMixin {
  var formKey = GlobalKey<FormState>();
  Student newStudent = Student.withoutInfo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Öğrenci"),
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
      decoration:
          InputDecoration(labelText: "Öğrenci adı:", hintText: "Meryem"),
      validator: firstNameValidator,
      onSaved: (String value) {
        newStudent.firstName = value;
      },
    );
  }

  Widget buildLastNameText() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci soyadı:", hintText: "D"),
      validator: lastNameValidator,
      onSaved: (String value) {
        newStudent.lastName = value;
      },
    );
  }

  Widget buildGradeText() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Öğrenci'nin aldığı not:", hintText: "60"),
      validator: gradeValidator,
      onSaved: (String value) {
        newStudent.grade = int.parse(value);
      },
    );
  }

  Widget buildReturnButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          widget.students.add(newStudent);
          Navigator.pop(context);
        }
      },
    );
  }
}
