import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

part 'password.g.dart';

@HiveType(typeId: 1)
class Password {

  // Key = email + title

  @HiveField(0)
  final String email;

  @HiveField(1)
  final String encryptedPw;

  @HiveField(2)
  final String title;

  @HiveField(3)
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
