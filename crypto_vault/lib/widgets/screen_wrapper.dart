import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';

class ScreenWrapper extends StatefulWidget {
  final screen;
  final isDrawerOpen;
  final Function toggleDrawer;
  final Function openDrawer;
  final Function closeDrawer;
  final AnimationController menuArrowAnimationController;

  ScreenWrapper({
    @required this.screen,
    @required this.isDrawerOpen,
    @required this.toggleDrawer,
    @required this.openDrawer,
    @required this.closeDrawer,
    @required this.menuArrowAnimationController,
  });

  @override
  _ScreenWrapperState createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  double _xOffset;
  double _yOffset;
  double _scaleFactor;

  @override
  Widget build(BuildContext context) {
    if (widget.isDrawerOpen) {
      _xOffset = 250;
      _yOffset = 120;
      _scaleFactor = 0.7;
    } else {
      _xOffset = 0;
      _yOffset = 0;
      _scaleFactor = 1;
    }
    return GestureDetector(
      onHorizontalDragUpdate: (event) {
        if (event.delta.dx < 0) {
          widget.closeDrawer();
        } else if (event.delta.dx > 0 && event.localPosition.dx < 60) {
          widget.openDrawer();
        }
      },
      child: AnimatedContainer(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(widget.isDrawerOpen ? 40 : 0),
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        transform: Matrix4.translationValues(_xOffset, _yOffset, 0)
          ..scale(_scaleFactor),
        duration: Duration(milliseconds: 700),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 8,
                top: 32,
              ),
              child: IconButton(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_arrow,
                  progress: widget.menuArrowAnimationController,
                ),
                onPressed: widget.toggleDrawer,
              ),
            ),
            Flexible(child: widget.screen),
          ],
        ),
      ),
    );
  }
}
