import 'package:flutter/material.dart';

import 'package:crypto_vault/widgets/drawer_icon.dart';

class HomeScreen extends StatefulWidget {
  static const screenName = 'Home';
  static final icon = DrawerIcon(Icons.home_outlined);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Screen',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
