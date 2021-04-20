import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/screens/add_password_screen.dart';
import 'package:crypto_vault/screens/add_note_screen.dart';

class CustomFAB extends StatefulWidget {
  @override
  _CustomFABState createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AddNoteScreen(),
              ));
            },
          ),
          SpeedDialChild(
            backgroundColor: blue,
            labelBackgroundColor: blue,
            labelStyle: TextStyle(color: Colors.black),
            child: Icon(Icons.vpn_key),
            label: 'Add Password',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AddPasswordScreen(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
