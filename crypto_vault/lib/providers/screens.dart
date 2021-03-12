import 'package:flutter/material.dart';

import 'package:crypto_vault/data/screen_data.dart';
import 'package:crypto_vault/screens/main_screens/home_screen.dart';

class Screens with ChangeNotifier {
  String _screenName = HomeScreen.screenName;

  String get screenName {
    return _screenName;
  }

  Widget get currScreen {
    return screens[_screenName].screen;
  }

  void changeScreen(String screenName) {
    if (screens.containsKey(screenName)) {
      _screenName = screenName;
      notifyListeners();
    }
  }
}
