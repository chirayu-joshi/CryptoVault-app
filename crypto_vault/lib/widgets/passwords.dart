import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:crypto_vault/models/password.dart';
import 'package:crypto_vault/widgets/item_card.dart';

class PasswordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box<Password>('passwords'),
      builder: (context, passwordsBox) {
        final List<Password> _pwList = passwordsBox.values.toList();
        Map<String, List<ItemCard>> _pwMap = {};

        for (Password pw in _pwList) {
          if (_pwMap.containsKey(pw.title[0].toLowerCase())) {
            _pwMap[pw.title[0].toLowerCase()].add(
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
            _pwMap[pw.title[0].toLowerCase()] = _itemCardList;
          }
        }

        List<Widget> _pwItemCardList = [];
        for (int i = 0; i < 26; ++i) {
          if (_pwMap.containsKey(String.fromCharCode(i + 97))) {
            _pwItemCardList.add(Text(' ' + String.fromCharCode(i + 65)));
            for (ItemCard itemCard in _pwMap[String.fromCharCode(i + 97)]) {
              _pwItemCardList.add(itemCard);
            }
            _pwItemCardList.add(const SizedBox(height: 16));
          }
        }

        return ListView.builder(
          itemCount: _pwItemCardList.length,
          itemBuilder: (BuildContext ctx, int index) {
            return _pwItemCardList[index];
          },
        );
      },
    );
  }
}
