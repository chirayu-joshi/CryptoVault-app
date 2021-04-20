import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:encrypt/encrypt.dart' as enc;

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/models/password.dart';
import 'package:crypto_vault/widgets/input_field.dart';
import 'package:crypto_vault/providers/local_auth.dart';
import 'package:crypto_vault/screens/generate_password_screen.dart';

class AddPasswordScreen extends StatefulWidget {
  @override
  _AddPasswordScreenState createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final _titleController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _webURLController = TextEditingController();

  FocusNode _usernameFocusNode;
  FocusNode _emailFocusNode;
  FocusNode _pwFocusNode;
  FocusNode _webURLFocusNode;

  @override
  void initState() {
    _usernameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _pwFocusNode = FocusNode();
    _webURLFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _pwFocusNode.dispose();
    _webURLFocusNode.dispose();
    _titleController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _pwController.dispose();
    _webURLController.dispose();
    super.dispose();
  }

  void _onPasswordSave(BuildContext ctx) {
    if (_titleController.text == '' ||
        _emailController.text == '' ||
        _pwController.text == '') {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Title, Email and Password are required')),
      );
      return;
    }

    String masterPw32 = Provider.of<LocalAuth>(context, listen: false).masterPw;
    if (masterPw32.length > 32) {
      masterPw32 = masterPw32.substring(0, 32);
    }

    int masterPw32Len = masterPw32.length;
    for (int i = 0; i < (32 - masterPw32Len); ++i) {
      masterPw32 += '=';
    }

    final key = enc.Key.fromUtf8(masterPw32);
    final iv = enc.IV.fromSecureRandom(16);

    final encrypter = enc.Encrypter(enc.AES(key));

    final _encryptedPw = encrypter.encrypt(_pwController.text, iv: iv);

    final passwordBox = Hive.box<Password>('passwords');
    final passwordModel = Password(
      title: _titleController.text,
      email: _emailController.text,
      encryptedPw: _encryptedPw.base64,
      iv: iv.base64,
    );
    if (_usernameController.text != '')
      passwordModel.username = _usernameController.text;
    if (_webURLController.text != '')
      passwordModel.websiteURL = _webURLController.text;

    if (passwordBox
        .containsKey(_emailController.text + _titleController.text)) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('Email already exist for ' + _titleController.text),
        ),
      );
      return;
    }

    passwordBox.put(
      _emailController.text + _titleController.text,
      passwordModel,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorLight,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.headline6.color,
        ),
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
              onPressed: () => _onPasswordSave(context),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              InputField(
                hintText: 'Title',
                controller: _titleController,
                prefixIcon: Icon(Icons.title),
                textInputAction: TextInputAction.next,
                onSubmitted: () {
                  _usernameFocusNode.requestFocus();
                },
              ),
              SizedBox(
                height: 16,
              ),
              InputField(
                hintText: 'Username',
                controller: _usernameController,
                prefixIcon: Icon(Icons.account_circle_outlined),
                textInputAction: TextInputAction.next,
                focusNode: _usernameFocusNode,
                onSubmitted: () {
                  _emailFocusNode.requestFocus();
                },
              ),
              SizedBox(
                height: 16,
              ),
              InputField(
                hintText: 'Email',
                controller: _emailController,
                prefixIcon: Icon(Icons.email_outlined),
                textInputAction: TextInputAction.next,
                focusNode: _emailFocusNode,
                onSubmitted: () {
                  _pwFocusNode.requestFocus();
                },
              ),
              SizedBox(
                height: 16,
              ),
              InputField(
                prefixIcon: Icon(Icons.vpn_key_outlined),
                hintText: 'Password',
                controller: _pwController,
                textInputAction: TextInputAction.next,
                focusNode: _pwFocusNode,
                suffixIcon: TextButton(
                  onPressed: () async {
                    final generatedPw = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => GeneratePasswordScreen(),
                      ),
                    );
                    _pwController.text = generatedPw;
                  },
                  child: const Padding(
                    child: const Text(
                      'GENERATE',
                    ),
                    padding: const EdgeInsets.only(right: 8),
                  ),
                ),
                onSubmitted: (value) {
                  _webURLFocusNode.requestFocus();
                },
              ),
              SizedBox(
                height: 16,
              ),
              InputField(
                hintText: 'Website URL',
                controller: _webURLController,
                prefixIcon: Icon(Icons.language),
                textInputAction: TextInputAction.done,
                focusNode: _webURLFocusNode,
                onSubmitted: () => _onPasswordSave(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
