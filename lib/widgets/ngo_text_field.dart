import 'package:flutter/material.dart';

ngoTextField(String hintText, TextEditingController controller,
    TextInputType textInputType, bool obscure,int maxLines) {
  return TextField(
    maxLines: maxLines,
    obscureText: obscure,
    controller: controller,
    keyboardType: TextInputType.name,
    decoration: InputDecoration(
      isDense: true,
      filled: true,
      fillColor: Colors.grey.withOpacity(
        0.4,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.black,
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: const OutlineInputBorder(),
    ),
  );
}
