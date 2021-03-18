import 'package:flutter/foundation.dart';

class Note {
  final String title;
  final String encryptedContent;

  Note({
    @required this.title,
    @required this.encryptedContent,
  });

  String get decryptedContent {
    return '';
  }
}
