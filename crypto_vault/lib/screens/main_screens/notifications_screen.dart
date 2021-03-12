import 'package:flutter/material.dart';

import 'package:crypto_vault/widgets/drawer_icon.dart';

class NotificationsScreen extends StatelessWidget {
  static const screenName = 'Notifications';
  static final icon = DrawerIcon(Icons.notifications_none_outlined);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notifications Screen'),
    );
  }
}
