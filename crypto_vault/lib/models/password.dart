import 'package:flutter/foundation.dart';

class Password {
  final String email;
  final String encryptedPw;
  final String title;
  bool isFavourite;

  Password({
    @required this.email,
    @required this.encryptedPw,
    @required this.title,
  });

  String get decryptedPw {
    return '';
  }
}
