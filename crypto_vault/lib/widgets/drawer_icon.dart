import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';

class DrawerIcon extends StatelessWidget {
  final icon;

  DrawerIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: backgroundColorDark,
    );
  }
}
