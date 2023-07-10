import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

textField(TextEditingController controller, String label, Icon icon,TextInputType textInputType,bool obscure) {
  return TextField(
    keyboardType: textInputType,
    obscureText: obscure,
    style: const TextStyle(
      color: Colors.white,
    ),
    controller: controller,
    cursorColor: Colors.white,
    decoration: InputDecoration(
      isDense: true,
      prefixIcon: icon,
      labelText: label,
      labelStyle: GoogleFonts.abyssinicaSil(
        color: Colors.white,
        fontSize: 18,
        letterSpacing: 2,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.green,
        ),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
    ),
  );
}
