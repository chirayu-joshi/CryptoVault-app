import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';

class WideButton extends StatelessWidget {
  final Function onPressed;
  final text;
  final isMain;

  WideButton({
    @required this.onPressed,
    @required this.text,
    this.isMain = false,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20),
      buttonColor: isMain ? textLight : backgroundColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isMain
            ? BorderSide()
            : BorderSide(
                color: textLight,
                width: 2,
              ),
      ),
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        textColor: isMain ? backgroundColorLight : textLight
      ),
    );
  }
}
