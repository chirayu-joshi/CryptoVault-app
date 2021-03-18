import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:crypto_vault/providers/notes.dart';
import 'package:crypto_vault/models/note.dart';
import 'package:crypto_vault/widgets/item_card.dart';

class NotesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Note> _noteList = Provider.of<Notes>(context).noteList;
    Map<String, List<ItemCard>> _noteMap = {};

    for (Note note in _noteList) {
      if (_noteMap.containsKey(note.title[0].toLowerCase())) {
        _noteMap[note.title[0].toLowerCase()].add(
          ItemCard(
            title: note.title,
            description: note.encryptedContent,
            type: 'Note',
          ),
        );
      } else {
        List<ItemCard> _itemCardList = [];
        _itemCardList.add(
          ItemCard(
            title: note.title,
            description: note.encryptedContent,
            type: 'Note',
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

    return ListView.builder(
      itemCount: _noteItemCardList.length,
      itemBuilder: (BuildContext ctx, int index) {
        return _noteItemCardList[index];
      },
    );
  }
}
