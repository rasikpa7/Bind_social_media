
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final String label;
  final IconData prefixIcon;
  TextFieldInput(
      {Key? key,
      required this.hintText,
      this.isPass = false,
      required this.textEditingController,
      required this.textInputType,
      required this.label,
      required this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: isPass,
      decoration: InputDecoration(
          label: Text(label),
          prefixIcon: Icon(prefixIcon),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
