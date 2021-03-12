import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/providers/screens.dart';

class DrawerItem extends StatelessWidget {
  final title;
  final icon;
  final Function toggleDrawer;

  DrawerItem({
    @required this.title,
    @required this.icon,
    @required this.toggleDrawer,
  });

  @override
  Widget build(BuildContext context) {
    final screensData = Provider.of<Screens>(context);
    return GestureDetector(
      onTap: () {
        toggleDrawer();
        screensData.changeScreen(title);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: screensData.screenName == title
              ? Colors.white30
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: <Widget>[
            icon,
            SizedBox(width: 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: backgroundColorDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
