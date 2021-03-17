import 'package:flutter/material.dart';

import 'package:crypto_vault/widgets/drawer_icon.dart';

class PasswordsScreen extends StatelessWidget {
  static const screenName = 'Passwords';
  static final icon = DrawerIcon(Icons.vpn_key_outlined);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Passwords Screen',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
