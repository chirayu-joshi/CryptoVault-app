import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/widgets/input_field.dart';
import 'package:crypto_vault/widgets/wide_button.dart';

class CreateMasterPasswordScreen extends StatefulWidget {
  static const routeName = '/createMasterPassword';

  @override
  _CreateMasterPasswordScreenState createState() =>
      _CreateMasterPasswordScreenState();
}

class _CreateMasterPasswordScreenState
    extends State<CreateMasterPasswordScreen> {
  Timer _timer;

  int _pageState = 0;

  String _heading = '';
  String _description = '';

  double _windowHeight = 0;
  double _windowWidth = 0;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _createHeight = 0;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _createYOffset = 0;

  double _loginOpacity = 0;

  bool _showPass = false;

  _CreateMasterPasswordScreenState() {
    _timer = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        _pageState = 1;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _windowHeight = MediaQuery.of(context).size.height;
    _windowWidth = MediaQuery.of(context).size.width;

    if (_pageState == 0) {
      _loginYOffset = _windowHeight;
      _createYOffset = _windowHeight;
    } else if (_pageState == 1) {
      _heading = 'Master Password';
      _description =
          'Master Password is used to encrypt all your data, and it is not stored anywhere. Make sure to remember it!';

      _loginWidth = _windowWidth - 50;
      _loginOpacity = 0.5;
      _loginXOffset = 25;
      _loginYOffset = 245;
      _loginHeight = _windowHeight - 245;

      _createYOffset = 270;
      _createHeight = _windowHeight - 270;
    } else {
      _heading = 'Welcome Back!';
      _description =
          'Enter your credentials to fetch and decrypt your backed up data.';

      _loginWidth = _windowWidth;
      _loginOpacity = 1;
      _loginXOffset = 0;
      _loginYOffset = 270;
      _loginHeight = _windowHeight - 270;

      _createYOffset = _windowHeight;
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Theme.of(context).canvasColor,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 64,
                ),
                Text(
                  _heading,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  _description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textDark,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastLinearToSlowEaseIn,
            transform:
                Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
            width: _loginWidth,
            height: _loginHeight,
            decoration: BoxDecoration(
              color: backgroundColorLight.withOpacity(_loginOpacity),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastLinearToSlowEaseIn,
            transform: Matrix4.translationValues(0, _createYOffset, 1),
            height: _createHeight,
            padding: EdgeInsets.symmetric(horizontal: 48),
            decoration: BoxDecoration(
              color: backgroundColorLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                  width: double.infinity,
                ),
                Text(
                  'Create your Master Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: InputField(
                    hintText: 'Master Password',
                    isPassword: !_showPass,
                    prefixIcon: Icon(
                      Icons.vpn_key,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPass ? Icons.security : Icons.remove_red_eye,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPass = !_showPass;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: <Widget>[
                      WideButton(
                        onPressed: () {
                          setState(() {
                            _pageState = 2;
                          });
                        },
                        text: 'Save Password',
                        isMain: true,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      WideButton(
                        onPressed: () {
                          setState(() {
                            _pageState = 2;
                          });
                        },
                        text: 'Login',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
