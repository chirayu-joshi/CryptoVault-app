import 'package:flutter/material.dart';

import 'package:crypto_vault/screens/onboarding_screen.dart';
import 'package:crypto_vault/screens/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  OnboardingScreen.routeName: (context) => OnboardingScreen(),
  HomePage.routeName: (context) => HomePage(title: 'CryptoVault'),
};
