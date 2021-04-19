import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/helpers/password_generator.dart';
import 'package:crypto_vault/widgets/custom_slider.dart';

class GeneratePasswordScreen extends StatefulWidget {
  @override
  _GeneratePasswordScreenState createState() => _GeneratePasswordScreenState();
}

class _GeneratePasswordScreenState extends State<GeneratePasswordScreen> {
  PasswordGenerator _passwordGenerator;
  String _currPw;

  _GeneratePasswordScreenState() {
    _passwordGenerator = PasswordGenerator(16, true, true, true);
    _currPw = _passwordGenerator.password;
  }

  Color _getThemeColor() {
    switch (PasswordGenerator.getPwStrength(_currPw)) {
      case PasswordStrength.poor:
        return red;
      case PasswordStrength.weak:
        return amber;
      case PasswordStrength.good:
        return lime;
      case PasswordStrength.excellent:
        return green;
      default:
        return textLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _getThemeColor(),
        elevation: 0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.done), onPressed: () {}),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 160,
            padding: EdgeInsets.symmetric(horizontal: 32),
            color: _getThemeColor(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    _currPw,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _currPw = _passwordGenerator.generatePassword();
                        });
                      },
                      icon: Icon(Icons.autorenew),
                    ),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _currPw));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Password Copied to Clipboard!',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black54,
                          ),
                        );
                      },
                      icon: Icon(Icons.copy),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: secondaryColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Length',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '4',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Expanded(
                                child: CustomSlider(
                                  value: _currPw.length.toDouble(),
                                  min: 4,
                                  max: 64,
                                  divisions: 60,
                                  activeColor: _getThemeColor(),
                                  label: _currPw.length.toString(),
                                  onChanged: (double value) {
                                    _passwordGenerator.pwLength = value;
                                    setState(() {
                                      _currPw =
                                          _passwordGenerator.generatePassword();
                                    });
                                  },
                                ),
                              ),
                              Text(
                                '64',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SwitchListTile(
                      title: Text(
                        'Letters',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline6.color,
                          fontSize: 18,
                        ),
                      ),
                      activeColor: _getThemeColor(),
                      value: _passwordGenerator.hasLetters,
                      onChanged: (bool value) {
                        if (value ||
                            _passwordGenerator.hasSymbols ||
                            _passwordGenerator.hasDigits) {
                          _passwordGenerator.hasLetters = value;
                          setState(() {
                            _currPw = _passwordGenerator.generatePassword();
                          });
                        }
                      },
                    ),
                    SwitchListTile(
                      title: Text(
                        'Digits',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline6.color,
                          fontSize: 18,
                        ),
                      ),
                      activeColor: _getThemeColor(),
                      value: _passwordGenerator.hasDigits,
                      onChanged: (bool value) {
                        if (value ||
                            _passwordGenerator.hasLetters ||
                            _passwordGenerator.hasSymbols) {
                          _passwordGenerator.hasDigits = value;
                          setState(() {
                            _currPw = _passwordGenerator.generatePassword();
                          });
                        }
                      },
                    ),
                    SwitchListTile(
                      title: Text(
                        'Symbols',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline6.color,
                          fontSize: 18,
                        ),
                      ),
                      activeColor: _getThemeColor(),
                      value: _passwordGenerator.hasSymbols,
                      onChanged: (bool value) {
                        if (value ||
                            _passwordGenerator.hasLetters ||
                            _passwordGenerator.hasDigits) {
                          _passwordGenerator.hasSymbols = value;
                          setState(() {
                            _currPw = _passwordGenerator.generatePassword();
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
