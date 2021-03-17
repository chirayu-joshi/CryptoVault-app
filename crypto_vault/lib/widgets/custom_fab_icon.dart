import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:crypto_vault/constants.dart';

class CustomFABIcon extends StatefulWidget {
  @override
  _CustomFABIconState createState() => _CustomFABIconState();
}

class _CustomFABIconState extends State<CustomFABIcon> {
  bool isFABOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 512,
      width: 256,
      child: SpeedDial(
        overlayColor: backgroundColor,
        overlayOpacity: 0,
        foregroundColor: textLight,
        backgroundColor: secondaryColor,
        curve: Curves.bounceIn,
        icon: isFABOpen ? Icons.close : Icons.add,
        onOpen: () {
          setState(() {
            isFABOpen = true;
          });
        },
        onClose: () {
          setState(() {
            isFABOpen = false;
          });
        },
        children: [
          SpeedDialChild(
            backgroundColor: purple,
            labelBackgroundColor: purple,
            labelStyle: TextStyle(color: Colors.black),
            child: Icon(Icons.note),
            label: 'Add Note',
            onTap: () {
              print('Add note');
            },
          ),
          SpeedDialChild(
            backgroundColor: blue,
            labelBackgroundColor: blue,
            labelStyle: TextStyle(color: Colors.black),
            child: Icon(Icons.vpn_key),
            label: 'Add Password',
            onTap: () {
              print('Add password');
            },
          ),
        ],
      ),
    );
  }
}
