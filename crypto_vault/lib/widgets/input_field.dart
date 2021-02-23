import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';

class InputField extends StatelessWidget {
  final hintText;
  final controller;
  final prefixIcon;
  final suffixIcon;
  final isPassword;
  final Function onSubmitted;
  final focusNode;
  final textInputAction;
  final Function onTap;

  InputField({
    @required this.hintText,
    @required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      obscureText: isPassword,
      textInputAction: textInputAction,
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
      controller: controller,
      focusNode: focusNode,
      onSubmitted: (value) {
        onSubmitted(value);
      },
    );
  }
}
