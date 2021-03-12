import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/providers/local_auth.dart';
import 'package:crypto_vault/data/screen_data.dart';
import 'package:crypto_vault/widgets/drawer_item.dart';
import 'package:crypto_vault/screens/local_login_screen.dart';

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
      padding: EdgeInsets.only(top: 64, left: 16, bottom: 32),
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
          FlatButton.icon(
            onPressed: () {
              Provider.of<LocalAuth>(context, listen: false).logout();
              Navigator.of(context)
                  .pushReplacementNamed(LocalLoginScreen.routeName);
            },
            icon: Icon(
              Icons.lock,
              size: 18,
              color: backgroundColorDark,
            ),
            label: Text(
              'LOCK',
              style: TextStyle(fontSize: 14, color: backgroundColorDark),
            ),
          ),
        ],
      ),
    );
  }
}
