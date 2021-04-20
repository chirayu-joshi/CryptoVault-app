import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';
import 'package:encrypt/encrypt.dart' as enc;

/*
* Use command "flutter packages pub run build_runner build" to
* generate adapter file.
* */
part 'note.g.dart';

@HiveType(typeId: 2)
class Note {

  // Key = title

  @HiveField(0)
  final String title;

  @HiveField(1)
  final String encryptedContent;

  @HiveField(2)
  bool isFavourite = false;

  @HiveField(3)
  final String iv;

  Note({
    @required this.title,
    @required this.encryptedContent,
    @required this.iv
  });

  String getDecryptedContent(String masterPw) {
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

    return encrypter.decrypt64(encryptedContent, iv: enc.IV.fromBase64(iv));
  }

}
