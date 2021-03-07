class Student {
  int id;
  String firstName;
  String lastName;
  int grade;
  bool status;

  Student(String firstName, String lastName, int grade) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
  }

  Student.withId(int id, String firstName, String lastName, int grade) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
  }

  Student.withoutInfo();

  bool get getStatus {
    if (this.grade >= 50) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }
}
