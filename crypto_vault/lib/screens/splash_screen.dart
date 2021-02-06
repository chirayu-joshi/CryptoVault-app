import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

import 'package:crypto_vault/screens/home_screen.dart';
import 'package:crypto_vault/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  Future checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _firstTime = (prefs.getBool('firstTime') ?? false);

    if (_firstTime) {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } else {
      await prefs.setBool('firstTime', true);
      Navigator.of(context).pushReplacementNamed(OnboardingScreen.routeName);
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstTime();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
