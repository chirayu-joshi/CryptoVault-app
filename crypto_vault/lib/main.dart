import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:crypto_vault/app_theme.dart';
import 'package:crypto_vault/screens/splash_screen.dart';
import 'package:crypto_vault/routes.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      // set Status bar color in Android devices
      statusBarColor: const Color(0x33000000),
      // set Status bar icons color in Android devices.
      statusBarIconBrightness: Brightness.light,
      // set Status bar icon color in iOS.
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Vault',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: SplashScreen(),
      routes: routes,
    );
  }
}
