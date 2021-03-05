import 'package:flutter/material.dart';

import 'package:crypto_vault/screens/home_screen.dart';
import 'package:crypto_vault/screens/local_login_screen.dart';
import 'package:crypto_vault/screens/onboarding_screen.dart';
import 'package:crypto_vault/screens/create_master_password_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => HomePage(title: 'CryptoVault'),
  LocalLoginScreen.routeName: (context) => LocalLoginScreen(),
  OnboardingScreen.routeName: (context) => OnboardingScreen(),
  CreateMasterPasswordScreen.routeName: (context) => CreateMasterPasswordScreen(),
};
