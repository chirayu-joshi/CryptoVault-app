import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:provider/provider.dart';

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
  final String encryptedPw; // base64 version. Use encrypter.decrypt64()

  @HiveField(4)
  bool isFavourite;

  @HiveField(5)
  String websiteURL;

  @HiveField(6)
  final String iv;  // It contains base64 version of IV. Use IV.fromBase64()

  Password({
    @required this.title,
    @required this.email,
    @required this.encryptedPw,
    @required this.iv,
  });

  String getDecryptedPassword(String masterPw) {
    // For more information, refer documentation:
    // https://github.com/leocavalcante/encrypt
    if (masterPw.length > 32) {
      masterPw = masterPw.substring(0, 32);
    }

    int masterPwLen = masterPw.length;
    for (int i = 0; i < (32 - masterPwLen); ++i) {
      masterPw += '=';
    }

    final key = enc.Key.fromUtf8(masterPw);
    final encrypter = enc.Encrypter(enc.AES(key));

    return encrypter.decrypt64(encryptedPw, iv: enc.IV.fromBase64(iv));
  }
}
