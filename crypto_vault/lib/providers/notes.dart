import 'package:flutter/material.dart';

import 'package:crypto_vault/models/note.dart';

class Notes with ChangeNotifier {
  List<Note> _noteList = [
    Note(
      title: 'My Address',
      encryptedContent: '3idjfetejfknboe38^&*^84rg42rf5g434hrt58',
    ),
    Note(
      title: 'Personal Info',
      encryptedContent: 'boe&*^hrt584r328^&g42rf5g3idjfet234ejfkn4348',
    ),
    Note(
      title: 'Payment cards',
      encryptedContent: 'ej4hrt5fknboe203#@^84rg3i&*^djfet42rf5g438',
    ),
  ];

  List<Note> get noteList {
    return [..._noteList];
  }
}
