import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

/*
* Use command "flutter packages pub run build_runner build" to
* generate adapter file.
* */
part 'password.g.dart';

@HiveType(typeId: 1)
class Password {

  /* Structure of password screen:
  * App bar: star, edit, delete
  * Title: icon, title
  * Body: username, email, password, website url
  * */

  // Key = email + title

  @HiveField(0)
  final String email;

  @HiveField(1)
  final String title;

  @HiveField(2)
  String username;

  @HiveField(3)
  final String encryptedPw;

  @HiveField(4)
  bool isFavourite;

  @HiveField(5)
  String websiteURL;

  Password({
    @required this.email,
    @required this.encryptedPw,
    @required this.title,
  });

  String get decryptedPw {
    return '';
  }
}
