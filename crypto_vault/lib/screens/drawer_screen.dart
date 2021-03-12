import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/data/screen_data.dart';
import 'package:crypto_vault/widgets/drawer_item.dart';

class DrawerScreen extends StatelessWidget {
  final List<Widget> _drawerItems = [];
  final Function toggleDrawer;

  DrawerScreen({this.toggleDrawer});

  @override
  Widget build(BuildContext context) {
    screens.forEach((key, value) {
      _drawerItems.add(DrawerItem(
        title: key,
        icon: value.icon,
        toggleDrawer: toggleDrawer,
      ));
    });
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: primaryColor,
      padding: EdgeInsets.only(top: 64, left: 16, bottom: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Crypto Vault',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: backgroundColorDark,
              ),
            ),
          ),
          Container(
            width: 196,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _drawerItems,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Lock',
              style: TextStyle(
                fontSize: 16,
                color: backgroundColorDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
