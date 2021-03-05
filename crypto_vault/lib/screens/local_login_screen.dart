import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';

import 'package:crypto_vault/providers/local_auth.dart';
import 'package:crypto_vault/screens/home_screen.dart';
import 'package:crypto_vault/widgets/input_field.dart';
import 'package:crypto_vault/widgets/wide_button.dart';
import 'package:crypto_vault/widgets/scroll_column_expandable.dart';
import 'package:crypto_vault/constants.dart';

class LocalLoginScreen extends StatefulWidget {
  static const routeName = '/local-login';

  @override
  _LocalLoginScreenState createState() => _LocalLoginScreenState();
}

class _LocalLoginScreenState extends State<LocalLoginScreen> {
  // biometrics

  Timer _timer;

  int _pageState = 0;

  double _windowHeight = 0;
  double _loginHeight = 0;
  double _loginYOffset = 0;

  bool _isKeyboardOpen = false;

  final _masterPwController = TextEditingController();
  bool _isMasterPwValid = false;
  String _errorMessage = '';

  bool _showPass = false;

  _LocalLoginScreenState() {
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

  void _loginBtnPressHandler(BuildContext ctx) async {
    if (!_isMasterPwValid) {
      return;
    }

    final String _pw = _masterPwController.text;
    final _localAuthProvider = Provider.of<LocalAuth>(ctx, listen: false);

    await _localAuthProvider.login(_pw);
    if (_localAuthProvider.isAuthenticated) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(ctx).pushReplacementNamed(HomePage.routeName);
      });
      setState(() {
        _errorMessage = '';
      });
    } else {
      setState(() {
        _errorMessage = 'Entered password is incorrect.';
      });
    }
  }

  @override
  void initState() {
    _masterPwController.addListener(_pwChangeHandler);
    super.initState();
  }

  @override
  void dispose() {
    _masterPwController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _windowHeight = MediaQuery.of(context).size.height;
    _isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    if (_pageState == 0) {
      _loginYOffset = _windowHeight;
    } else {
      _loginYOffset = _isKeyboardOpen ? 45 : 240;
      _loginHeight = _windowHeight - 240;
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Theme.of(context).canvasColor,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 64,
                ),
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Enter your master password to continue.',
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
                Matrix4.translationValues(0, _loginYOffset, 1),
            // height: _windowHeight - 240,
            height: _loginHeight,
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
                  'Enter your Master Password',
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
                        _loginBtnPressHandler(context);
                      },
                    ),
                    if (_errorMessage != '')
                      Text(
                        _errorMessage,
                      ),
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: WideButton(
                    onPressed: () {
                      _loginBtnPressHandler(context);
                    },
                    text: 'Login',
                    isMain: true,
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
