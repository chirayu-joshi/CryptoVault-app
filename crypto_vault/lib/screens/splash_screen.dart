import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

import 'package:crypto_vault/screens/onboarding_screen.dart';
import 'package:crypto_vault/screens/create_master_password_screen.dart';
import 'package:crypto_vault/screens/local_login_screen.dart';
import 'package:crypto_vault/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  Future checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _firstTime = (prefs.getBool('firstTime') ?? true);
    bool _hasHashMasterPassword = (prefs.getString('pwHash') != null);

    if (_firstTime) {
      Navigator.of(context).pushReplacementNamed(OnboardingScreen.routeName);
    } else if (!_hasHashMasterPassword) {
      Navigator.of(context)
          .pushReplacementNamed(CreateMasterPasswordScreen.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(LocalLoginScreen.routeName);
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstTime();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
    );
  }
}
