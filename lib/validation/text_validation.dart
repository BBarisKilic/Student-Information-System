mixin textValidationMixin {
  String firstNameValidator(String text) {
    var nonValidCharacters = RegExp(r'[0-9_\-=@,\.;+*/$#£]');
    if (text.length < 2) {
      return "The name must be at least 2 characters.";
    }
    if (text.contains(nonValidCharacters)) {
      return "The name should not contain any special characters or numbers.";
    }
    return null;
  }

  String lastNameValidator(String text) {
    var nonValidCharacters = RegExp(r'[0-9_\-=@,\.;+*/$#£]');
    if (text.length < 2) {
      return "The surname must be at least 2 characters.";
    }
    if (text.contains(nonValidCharacters)) {
      return "The surname should be a special character or not.";
    }
    return null;
  }

  String gradeValidator(String text) {
    //var nonValidCharacters = RegExp(r'[a-zA-Z_\-=@,\.;+*/$#£]');
    var grade = int.parse(text);
    if (grade < 0 || grade > 100) {
      return "The grade must be between 0 and 100.";
    }
    return null;
  }
}
