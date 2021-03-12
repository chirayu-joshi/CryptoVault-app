import 'package:flutter/material.dart';

import 'package:crypto_vault/widgets/drawer_icon.dart';

class FaqsScreen extends StatelessWidget {
  static const screenName = 'FAQs';
  static final icon = DrawerIcon(Icons.help_outline);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('FAQs Screen'),
    );
  }
}
