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

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool _isDrawerOpen = false;
  AnimationController _menuArrowAnimationController;

  @override
  void initState() {
    _menuArrowAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
      reverseDuration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    _menuArrowAnimationController.dispose();
    super.dispose();
  }

  void _toggleDrawerHandler() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
      _isDrawerOpen
          ? _menuArrowAnimationController.forward()
          : _menuArrowAnimationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _currScreen = Provider.of<Screens>(context).currScreen;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DrawerScreen(
            toggleDrawer: _toggleDrawerHandler,
          ),
          ScreenWrapper(
            screen: _currScreen,
            isDrawerOpen: _isDrawerOpen,
            toggleDrawer: _toggleDrawerHandler,
            menuArrowAnimationController: _menuArrowAnimationController,
          ),
        ],
      ),
    );
  }
}
