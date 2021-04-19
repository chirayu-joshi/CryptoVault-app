import 'dart:math';

enum PasswordStrength {
  poor,
  weak,
  good,
  excellent,
}

class PasswordGenerator {
  String _pw;
  double pwLength;
  bool hasLetters;
  bool hasDigits;
  bool hasSymbols;

  PasswordGenerator(
    this.pwLength,
    this.hasLetters,
    this.hasDigits,
    this.hasSymbols,
  ) {
    generatePassword();
  }

  String generatePassword() {
    String allowedChars = '';
    if (hasLetters) {
      allowedChars += 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    }
    if (hasDigits) {
      // Characters are repeating so that there is nearly equal probability
      // of each character being selected.
      allowedChars += '01234567890123456789012345678901234567890123456789';
    }
    if (hasSymbols) {
      allowedChars += '@#=+!^*-_;:\'"/?.,<>~`\\\$%&?[](){}!@#\$%^&*()-_=+';
    }

    Random rand = Random.secure();
    _pw = '';
    for (int i = 0; i < pwLength.toInt(); ++i) {
      _pw += allowedChars[rand.nextInt(allowedChars.length)];
    }

    return _pw;
  }

  String get password {
    return _pw;
  }

  static PasswordStrength getPwStrength(String pw) {
    return PasswordStrength.excellent;
  }
}
