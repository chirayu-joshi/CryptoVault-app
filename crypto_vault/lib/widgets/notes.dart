import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:crypto_vault/models/note.dart';
import 'package:crypto_vault/widgets/item_card.dart';
import 'package:crypto_vault/providers/local_auth.dart';

class NotesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localAuthProvider = Provider.of<LocalAuth>(context, listen: false);

    return ValueListenableBuilder(
      valueListenable: Hive.box<Note>('notes').listenable(),
      builder: (context, notesBox, _) {
        final List<Note> _noteList = notesBox.values.toList();
        Map<String, List<ItemCard>> _noteMap = {};

        for (Note note in _noteList) {
          if (_noteMap.containsKey(note.title[0].toLowerCase())) {
            _noteMap[note.title[0].toLowerCase()].add(
              ItemCard(
                title: note.title,
                description: note.encryptedContent,
                type: 'Note',
                masterPw: localAuthProvider.masterPw,
              ),
            );
          } else {
            List<ItemCard> _itemCardList = [];
            _itemCardList.add(
              ItemCard(
                title: note.title,
                description: note.encryptedContent,
                type: 'Note',
                masterPw: localAuthProvider.masterPw,
              ),
            );
            _noteMap[note.title[0].toLowerCase()] = _itemCardList;
          }
        }

        List<Widget> _noteItemCardList = [];
        for (int i = 0; i < 26; ++i) {
          if (_noteMap.containsKey(String.fromCharCode(i + 97))) {
            _noteItemCardList.add(Text(' ' + String.fromCharCode(i + 65)));
            for (ItemCard itemCard in _noteMap[String.fromCharCode(i + 97)]) {
              _noteItemCardList.add(itemCard);
            }
            _noteItemCardList.add(const SizedBox(height: 16));
          }
        }

        if (_noteItemCardList.length == 0)
          return Text(
            'Nothing to show...',
            textAlign: TextAlign.center,
          );

        return ListView.builder(
          itemCount: _noteItemCardList.length,
          itemBuilder: (BuildContext ctx, int index) {
            return _noteItemCardList[index];
          },
        );
      },
    );
  }
}
