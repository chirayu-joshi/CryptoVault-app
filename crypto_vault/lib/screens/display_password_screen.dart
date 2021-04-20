import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hive/hive.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/models/password.dart';
import 'package:crypto_vault/providers/local_auth.dart';
import 'package:crypto_vault/widgets/title_description_tile.dart';
import 'package:crypto_vault/widgets/scroll_column_expandable.dart';

class DisplayPasswordScreen extends StatefulWidget {
  final Password password;

  DisplayPasswordScreen({@required this.password});

  @override
  _DisplayPasswordScreenState createState() => _DisplayPasswordScreenState();
}

class _DisplayPasswordScreenState extends State<DisplayPasswordScreen> {
  Timer _timer;

  int _pageState = 0;

  double _windowHeight = 0;
  double _pwHeight = 0;
  double _pwYOffset = 0;

  bool _isKeyboardOpen = false;

  bool _isFavourite;

  String _plainPw = '';

  _DisplayPasswordScreenState() {
    _timer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _pageState = 1;
      });
    });
  }

  @override
  void initState() {
    _isFavourite = widget.password.isFavourite;
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _toggleFavourite(BuildContext ctx) {
    final passwordBox = Hive.box<Password>('passwords');
    widget.password.isFavourite = _isFavourite;

    passwordBox.delete(widget.password.email + widget.password.title);
    passwordBox.put(
      widget.password.email + widget.password.title,
      widget.password,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localAuthProvider = Provider.of<LocalAuth>(context, listen: false);

    _windowHeight = MediaQuery.of(context).size.height;
    _isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    if (_pageState == 0) {
      _pwYOffset = _windowHeight;
    } else {
      _pwYOffset = _isKeyboardOpen ? 0 : 160;
      _pwHeight = _windowHeight - 160;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).textTheme.headline6.color,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actionsIconTheme: IconThemeData(
          color: Theme.of(context).textTheme.headline6.color,
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(_isFavourite ? Icons.star : Icons.star_border),
            onPressed: () {
              setState(() {
                _isFavourite = !_isFavourite;
              });
              _toggleFavourite(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Text('Delete?'),
                  content: Text('Do you wish to delete this password?'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text("YES"),
                      isDefaultAction: true,
                      onPressed: () {
                        Hive.box<Password>('passwords').delete(
                          widget.password.email + widget.password.title,
                        );
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Theme.of(context).canvasColor,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                CircleAvatar(
                  backgroundColor: blue,
                  minRadius: 44,
                  child: Text(
                    widget.password.title[0].toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 48),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.password.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastLinearToSlowEaseIn,
            transform: Matrix4.translationValues(0, _pwYOffset, 1),
            height: _pwHeight,
            padding: EdgeInsets.only(left: 32, right: 16),
            decoration: BoxDecoration(
              color: backgroundColorLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
            ),
            child: ScrollColumnExpandable(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 32,
                  width: double.infinity,
                ),
                if (widget.password.username != null &&
                    widget.password.username != '')
                  TitleDescriptionTile(
                    title: 'Username',
                    description: widget.password.username,
                  ),
                TitleDescriptionTile(
                  title: 'Email',
                  description: widget.password.email,
                ),
                TitleDescriptionTile(
                  title: 'Password',
                  description: _plainPw == '' ? '●●●●●●●●' : _plainPw,
                  actionButton: Row(
                    children: <Widget>[
                      IconButton(
                        icon: _plainPw == ''
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.security),
                        onPressed: () {
                          setState(() {
                            _plainPw = (_plainPw == ''
                                ? widget.password.getDecryptedPassword(
                                    localAuthProvider.masterPw)
                                : '');
                          });
                        },
                        padding: EdgeInsets.zero,
                      ),
                      IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: widget.password.getDecryptedPassword(
                                localAuthProvider.masterPw,
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Password Copied to Clipboard!',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                if (widget.password.websiteURL != '' &&
                    widget.password.websiteURL != null)
                  TitleDescriptionTile(
                    title: 'Website URL',
                    description: widget.password.websiteURL,
                    actionButton: IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () async => await canLaunch(
                              'http://' + widget.password.websiteURL)
                          ? await launch('http://' + widget.password.websiteURL)
                          : throw "Couldn't launch the URL",
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
