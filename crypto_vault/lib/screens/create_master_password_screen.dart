import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:provider/provider.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/providers/local_auth.dart';
import 'package:crypto_vault/widgets/input_field.dart';
import 'package:crypto_vault/widgets/wide_button.dart';
import 'package:crypto_vault/widgets/scroll_column_expandable.dart';
import 'package:crypto_vault/screens/main_screen.dart';

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

  bool _isKeyboardOpen = false;

  bool _showPass = false;

  final _masterPwController = TextEditingController();
  final _confirmPwController = TextEditingController();
  bool _isMasterPwValid = false;
  bool _didPwMatch = true;
  String _errorMessage = '';

  FocusNode _confirmPwFocusNode;

  _CreateMasterPasswordScreenState() {
    _timer = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        _pageState = 1;
      });
    });
  }

  void _pwChangeHandler() {
    String _pw = _masterPwController.text;
    if (_pw.length < 10) {
      setState(() {
        _errorMessage = 'At least 10 characters are required.';
        _isMasterPwValid = false;
      });
    } else if (!RegExp(r'[A-Z]').hasMatch(_pw)) {
      setState(() {
        _errorMessage = 'At least 1 uppercase character is required.';
        _isMasterPwValid = false;
      });
    } else if (!RegExp(r'[0-9]').hasMatch(_pw)) {
      setState(() {
        _errorMessage = 'At least 1 digit is required.';
        _isMasterPwValid = false;
      });
    } else if (!RegExp(r'[!@#$%^&*]').hasMatch(_pw)) {
      setState(() {
        _errorMessage =
            r'At least 1 special symbol (from !@#$%^&*) is required.';
        _isMasterPwValid = false;
      });
    } else {
      setState(() {
        _errorMessage = '';
        _isMasterPwValid = true;
      });
    }
  }

  void _confirmPwChangeHandler() {
    if (_isMasterPwValid &&
        _masterPwController.text == _confirmPwController.text) {
      setState(() {
        _didPwMatch = true;
      });
    }
  }

  void _savePasswordBtnPressHandler(BuildContext ctx) async {
    if (!_isMasterPwValid) {
      return;
    }

    if (_masterPwController.text != _confirmPwController.text) {
      setState(() {
        _didPwMatch = false;
      });
      return;
    } else {
      setState(() {
        _didPwMatch = true;
      });
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(ctx).pushReplacementNamed(MainScreen.routeName);
    });

    final String _pw = _masterPwController.text;
    final String _salt10 = await FlutterBcrypt.saltWithRounds(rounds: 10);
    final String _pwHash =
        await FlutterBcrypt.hashPw(password: _pw, salt: _salt10);

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('pwHash', _pwHash);

    Provider.of<LocalAuth>(ctx, listen: false).login(_pw);
  }

  @override
  void initState() {
    _masterPwController.addListener(_pwChangeHandler);
    _confirmPwController.addListener(_confirmPwChangeHandler);
    _confirmPwFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _masterPwController.dispose();
    _confirmPwController.dispose();
    _confirmPwFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _windowHeight = MediaQuery.of(context).size.height;
    _windowWidth = MediaQuery.of(context).size.width;
    _isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

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
      _loginYOffset = _isKeyboardOpen ? 45 : 245;
      _loginHeight = _windowHeight - 245;

      _createYOffset = _isKeyboardOpen ? 70 : 270;
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
            padding: EdgeInsets.symmetric(horizontal: 48),
            decoration: BoxDecoration(
              color: backgroundColorLight.withOpacity(_loginOpacity),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
            ),
            child: ScrollColumnExpandable(
              children: <Widget>[
                SizedBox(
                  height: 40,
                  width: double.infinity,
                ),
                Text(
                  'Coming soon...',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: <Widget>[
                      WideButton(
                        onPressed: () {
                          setState(() {
                            _pageState = 1;
                          });
                        },
                        text: 'Create Password',
                      ),
                    ],
                  ),
                ),
              ],
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
            child: ScrollColumnExpandable(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InputField(
                      controller: _masterPwController,
                      hintText: 'Master Password',
                      textInputAction: TextInputAction.next,
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
                      onSubmitted: (_) {
                        _confirmPwFocusNode.requestFocus();
                      },
                    ),
                    if (_errorMessage != '')
                      Text(
                        _errorMessage,
                      ),
                    SizedBox(
                      height: 8,
                    ),
                    InputField(
                      controller: _confirmPwController,
                      hintText: 'Confirm Password',
                      focusNode: _confirmPwFocusNode,
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
                      onSubmitted: (_) {
                        _savePasswordBtnPressHandler(context);
                      },
                    ),
                    Text(
                      _didPwMatch ? '' : 'Password did\'t match.',
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: <Widget>[
                      WideButton(
                        onPressed: () {
                          _savePasswordBtnPressHandler(context);
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
