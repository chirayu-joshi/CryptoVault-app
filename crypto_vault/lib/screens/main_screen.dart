import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:crypto_vault/providers/screens.dart';
import 'package:crypto_vault/screens/drawer_screen.dart';
import 'package:crypto_vault/widgets/screen_wrapper.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isDrawerOpen = false;

  void _toggleDrawerHandler() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _currScreen = Provider.of<Screens>(context).currScreen;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DrawerScreen(),
          ScreenWrapper(
            screen: _currScreen,
            isDrawerOpen: _isDrawerOpen,
            toggleDrawer: _toggleDrawerHandler,
          ),
        ],
      ),
    );
  }
}
