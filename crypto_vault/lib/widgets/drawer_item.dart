import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/widgets/custom_box_shadow.dart';
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        margin: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: screensData.screenName == title
              ? Colors.white24
              : Colors.transparent,
          boxShadow: screensData.screenName == title
              ? [
                  CustomBoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 16,
                    offset: Offset.zero,
                    blurStyle: BlurStyle.outer,
                  ),
                ]
              : [],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: <Widget>[
            icon,
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: backgroundColorDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
