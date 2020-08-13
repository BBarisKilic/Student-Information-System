mixin textValidationMixin {
  String firstNameValidator(String text) {
    var nonValidCharacters = RegExp(r'[0-9_\-=@,\.;+*/$#£]');
    if (text.length < 2) {
      return "İsim en az 2 karakter olmalıdır.";
    }

    if (text.contains(nonValidCharacters)) {
      return "İsim özel karakter veya rakam içermemelidir.";
    }
  }

  String lastNameValidator(String text) {
    var nonValidCharacters = RegExp(r'[0-9_\-=@,\.;+*/$#£]');
    if (text.length < 2) {
      return "Soyisim en az 2 karakter olmalıdır.";
    }
    if (text.contains(nonValidCharacters)) {
      return "Soyisim özel karakter veya rakam içermemelidir.";
    }
  }

  String gradeValidator(String text) {
    //var nonValidCharacters = RegExp(r'[a-zA-Z_\-=@,\.;+*/$#£]');
    var grade = int.parse(text);
    if (grade < 0 || grade > 100) {
      return "Not 0 ile 100 arasında olmalıdır.";
    }
  }
}
