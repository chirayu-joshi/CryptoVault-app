import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:crypto_vault/providers/local_auth.dart';

class HomeScreen extends StatefulWidget {
  static const screenName = 'Home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // print(Provider.of<LocalAuth>(context, listen: false).isAuthenticated);
    // print(Provider.of<LocalAuth>(context, listen: false).masterPw);
    return Center(
      child: Text(
        'Home Screen',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
