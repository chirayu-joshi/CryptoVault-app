import 'package:flutter/material.dart';

import 'package:crypto_vault/screens/home_screen.dart';

class Screens with ChangeNotifier {
  final _screens = {
    HomeScreen.screenName: HomeScreen(),
  };
  String _screenName = HomeScreen.screenName;

  Widget get currScreen {
    return _screens[_screenName];
  }

  void changeScreen(String screenName) {
    if (_screens.containsKey(screenName)) {
      _screenName = screenName;
      notifyListeners();
    }
  }
}
