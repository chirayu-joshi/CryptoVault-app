import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

import 'package:crypto_vault/providers/notes.dart';
import 'package:crypto_vault/models/password.dart';
import 'package:crypto_vault/models/note.dart';
import 'package:crypto_vault/widgets/item_card.dart';

class AllItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box<Password>('passwords'),
      builder: (context, passwordsBox) {

        final List<Password> _pwList = passwordsBox.values.toList();
        final List<Note> _noteList = Provider.of<Notes>(context).noteList;
        Map<String, List<ItemCard>> _allItemsMap = {};

        for (Password pw in _pwList) {
          if (_allItemsMap.containsKey(pw.title[0].toLowerCase())) {
            _allItemsMap[pw.title[0].toLowerCase()].add(
              ItemCard(
                title: pw.title,
                description: pw.email,
                type: 'Password',
              ),
            );
          } else {
            List<ItemCard> _itemCardList = [];
            _itemCardList.add(
              ItemCard(
                title: pw.title,
                description: pw.email,
                type: 'Password',
              ),
            );
            _allItemsMap[pw.title[0].toLowerCase()] = _itemCardList;
          }
        }

        for (Note note in _noteList) {
          if (_allItemsMap.containsKey(note.title[0].toLowerCase())) {
            _allItemsMap[note.title[0].toLowerCase()].add(
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
            _allItemsMap[note.title[0].toLowerCase()] = _itemCardList;
          }
        }

        List<Widget> _allItemsList = [];
        for (int i = 0; i < 26; ++i) {
          if (_allItemsMap.containsKey(String.fromCharCode(i + 97))) {
            _allItemsList.add(Text(' ' + String.fromCharCode(i + 65)));
            for (ItemCard itemCard
                in _allItemsMap[String.fromCharCode(i + 97)]) {
              _allItemsList.add(itemCard);
            }
            _allItemsList.add(const SizedBox(height: 16));
          }
        }

        return ListView.builder(
          itemCount: _allItemsList.length,
          itemBuilder: (BuildContext ctx, int index) {
            return _allItemsList[index];
          },
        );
      },
    );
  }
}
