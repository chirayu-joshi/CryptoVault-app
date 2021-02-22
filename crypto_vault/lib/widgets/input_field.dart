import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';

class InputField extends StatelessWidget {
  final hintText;
  final prefixIcon;
  final suffixIcon;
  final isPassword;

  InputField({
    @required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword=false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      style: TextStyle(
        fontSize: 16,
        color: textLight,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Color(0x0fffffff),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: textDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: textLight),
        ),
      ),
      onSubmitted: (value) {
        print(value);
      },
    );
  }
}
