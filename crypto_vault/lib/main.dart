import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:crypto_vault/app_theme.dart';
import 'package:crypto_vault/providers/local_auth.dart';
import 'package:crypto_vault/providers/screens.dart';
import 'package:crypto_vault/providers/passwords.dart';
import 'package:crypto_vault/providers/notes.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LocalAuth()),
        ChangeNotifierProvider(create: (ctx) => Screens()),
        ChangeNotifierProvider(create: (ctx) => Passwords()),
        ChangeNotifierProvider(create: (ctx) => Notes()),
      ],
      child: MaterialApp(
        title: 'Crypto Vault',
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: SplashScreen(),
        routes: routes,
      ),
    );
  }
}
