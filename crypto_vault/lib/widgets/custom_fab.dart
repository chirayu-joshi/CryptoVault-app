import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive/hive.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/models/password.dart';

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
              // TODO: Update this method.
              var box = Hive.box<Password>('passwords');
              box.put(
                'chirayu@gmail.comgmail',
                Password(
                  email: 'chirayu@gmail.com',
                  encryptedPw: 'kdh423#@%5:""',
                  title: 'Gmail',
                ),
              );
              box.put(
                '18it007@charusat.edu.ingmail',
                Password(
                  email: '18it007@charusat.edu.in',
                  encryptedPw: 'poiu!@#432@^"[}."',
                  title: 'Gmail',
                ),
              );
              box.put(
                'chirayu@facebook.comfacebook',
                Password(
                  email: 'chirayu@facebook.com',
                  encryptedPw: 'uirh@#^&*(345',
                  title: 'Facebook',
                ),
              );
              box.put(
                'chirayu@linkedin.comlinkedin',
                Password(
                  email: 'chirayu@linkedin.com',
                  encryptedPw: '65-09_#@@!*(*&({|,',
                  title: 'LinkedIn',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
