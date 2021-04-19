import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:crypto_vault/providers/local_auth.dart';
import 'package:crypto_vault/providers/screens.dart';
import 'package:crypto_vault/providers/notes.dart';
import 'package:crypto_vault/models/password.dart';
import 'package:crypto_vault/screens/splash_screen.dart';
import 'package:crypto_vault/app_theme.dart';
import 'package:crypto_vault/routes.dart';

void main() async {
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

  WidgetsFlutterBinding.ensureInitialized();

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
  if (!containsEncryptionKey) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: 'key', value: base64UrlEncode(key));
  }

  var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key'));

  await Hive.initFlutter();
  Hive.registerAdapter(PasswordAdapter());
  await Hive.openBox<Password>(
    'passwords',
    encryptionCipher: HiveAesCipher(encryptionKey),
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
