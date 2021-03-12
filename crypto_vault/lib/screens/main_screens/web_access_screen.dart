import 'package:flutter/material.dart';

import 'package:crypto_vault/widgets/drawer_icon.dart';

class WebAccessScreen extends StatelessWidget {
  static const screenName = 'Web Access';
  static final icon = DrawerIcon(Icons.language_outlined);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Web Access Screen'),
    );
  }
}
