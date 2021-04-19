import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/widgets/input_field.dart';
import 'package:crypto_vault/screens/generate_password_screen.dart';

class AddPasswordScreen extends StatefulWidget {
  @override
  _AddPasswordScreenState createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _webURLController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Password',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              child: Text(
                'SAVE',
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline6.color,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w900,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
        backgroundColor: backgroundColorLight,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.headline6.color,
        ),
      ),
      body: Container(
        color: backgroundColorDark,
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            InputField(
              hintText: 'Username',
              controller: _usernameController,
              prefixIcon: Icon(Icons.account_circle_outlined),
            ),
            SizedBox(
              height: 16,
            ),
            InputField(
              hintText: 'Email',
              controller: _emailController,
              prefixIcon: Icon(Icons.email_outlined),
            ),
            SizedBox(
              height: 16,
            ),
            InputField(
              prefixIcon: Icon(Icons.vpn_key_outlined),
              hintText: 'Password',
              controller: _pwController,
              suffixIcon: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return GeneratePasswordScreen();
                  }));
                },
                child: const Padding(
                  child: const Text(
                    'GENERATE',
                  ),
                  padding: const EdgeInsets.only(right: 8),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            InputField(
              hintText: 'Website URL',
              controller: _webURLController,
              prefixIcon: Icon(Icons.language),
            ),
          ],
        ),
      ),
    );
  }
}
