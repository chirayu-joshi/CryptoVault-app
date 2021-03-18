import 'package:flutter/material.dart';

import 'package:crypto_vault/models/password.dart';

class Passwords with ChangeNotifier {
  List<Password> _pwList = [
    Password(
      email: 'chirayu@gmail.com',
      encryptedPw: 'kdh423#@%5:""',
      title: 'Gmail',
    ),
    Password(
      email: '18it007@charusat.edu.in',
      encryptedPw: 'poiu!@#432@^"[}."',
      title: 'Gmail',
    ),
    Password(
      email: 'chirayu@facebook.com',
      encryptedPw: 'uirh@#^&*(345',
      title: 'Facebook',
    ),
    Password(
      email: 'chirayu@facebook.com',
      encryptedPw: '65-09_#@@!*(*&({|,',
      title: 'LinkedIn',
    ),
  ];

  List<Password> get pwList {
    return [..._pwList];
  }
}
