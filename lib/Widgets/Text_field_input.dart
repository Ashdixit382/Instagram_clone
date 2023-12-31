import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController texteditingcontroller;
  final bool ispass;
  final String hintText;
  final TextInputType textinputtype;

  const TextFieldInput(
      {super.key,
      required this.texteditingcontroller,
      this.ispass = false,
      required this.hintText,
      required this.textinputtype});

  @override
  Widget build(BuildContext context) {
    final inputborder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: texteditingcontroller,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputborder,
        focusedBorder: inputborder,
        enabledBorder: inputborder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textinputtype,
      obscureText: ispass,
    );
  }
}
