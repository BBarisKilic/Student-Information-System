import 'package:flutter/material.dart';
import 'package:student_information_system/models/student.dart';
import 'package:student_information_system/validation/text_validation.dart';

// ignore: must_be_immutable
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
        title: Text("New Student"),
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
          InputDecoration(labelText: "Student Name:", hintText: "Meryem"),
      validator: firstNameValidator,
      onSaved: (String value) {
        newStudent.firstName = value;
      },
    );
  }

  Widget buildLastNameText() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Student Surname:", hintText: "D"),
      validator: lastNameValidator,
      onSaved: (String value) {
        newStudent.lastName = value;
      },
    );
  }

  Widget buildGradeText() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Student's grade:", hintText: "60"),
      validator: gradeValidator,
      onSaved: (String value) {
        newStudent.grade = int.parse(value);
      },
    );
  }

  Widget buildReturnButton() {
    return ElevatedButton(
      child: Text("Save"),
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
