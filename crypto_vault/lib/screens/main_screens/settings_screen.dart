import 'package:flutter/material.dart';

import 'package:crypto_vault/widgets/drawer_icon.dart';

class SettingsScreen extends StatelessWidget {
  static const screenName = 'Settings';
  static final icon = DrawerIcon(Icons.settings);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Screen'),
    );
  }
}
