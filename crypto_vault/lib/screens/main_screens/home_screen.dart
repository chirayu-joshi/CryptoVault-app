import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/widgets/drawer_icon.dart';
import 'package:crypto_vault/widgets/custom_tab_indicator.dart';
import 'package:crypto_vault/widgets/custom_fab_icon.dart';

class HomeScreen extends StatefulWidget {
  static const screenName = 'Home';
  static final icon = DrawerIcon(Icons.home_outlined);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                HomeScreen.screenName,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                height: 56,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: AppBar(
                  backgroundColor: backgroundColorDark,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  flexibleSpace: TabBar(
                    indicator: CustomTabIndicator(),
                    labelColor: textLight,
                    unselectedLabelColor: textDark,
                    tabs: [
                      Tab(text: 'All'),
                      Tab(text: 'Passwords'),
                      Tab(text: 'Secure Notes'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: TabBarView(
                    children: [
                      Center(
                        child: Text(
                          'All Passwords and Notes',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Passwords',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Secure Notes',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 24,
          right: 24,
          child: CustomFABIcon(),
        ),
      ],
    );
  }
}
