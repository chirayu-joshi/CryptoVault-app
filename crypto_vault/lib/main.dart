import 'dart:convert';
import 'dart:io';

import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:crypto_vault/providers/local_auth.dart';
import 'package:crypto_vault/providers/screens.dart';
import 'package:crypto_vault/models/password.dart';
import 'package:crypto_vault/models/note.dart';
import 'package:crypto_vault/screens/splash_screen.dart';
import 'package:crypto_vault/app_theme.dart';
import 'package:crypto_vault/routes.dart';
import 'package:crypto_vault/http_overrides.dart';

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
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Password>(
    'passwords',
    encryptionCipher: HiveAesCipher(encryptionKey),
  );
  await Hive.openBox<Note>(
    'notes',
    encryptionCipher: HiveAesCipher(encryptionKey),
  );

  // TODO: Remove self signed certificate in production mode
  HttpOverrides.global = CustomHttpOverrides();   // Allows all bad certificates
  try {
    print((await http.get(Uri.https(SERVER_IP, '/m/api/v1'))).body);
  } catch (_) {
    print('Cannot send request');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LocalAuth()),
        ChangeNotifierProvider(create: (ctx) => Screens()),
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
