import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/models/note.dart';

class DisplayNoteScreen extends StatelessWidget {

  final Note note;

  DisplayNoteScreen({@required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'F',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    color: textLight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
