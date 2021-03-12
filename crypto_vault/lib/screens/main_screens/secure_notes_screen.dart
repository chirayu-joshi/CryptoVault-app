import 'package:flutter/material.dart';

import 'package:crypto_vault/widgets/drawer_icon.dart';

class SecureNotesScreen extends StatelessWidget {
  static const screenName = 'Secure Notes';
  static final icon = DrawerIcon(Icons.note_outlined);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Secure Notes Screen'),
    );
  }
}
