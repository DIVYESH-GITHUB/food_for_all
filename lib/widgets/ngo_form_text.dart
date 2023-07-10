import 'package:flutter/material.dart';

ngoFormText(String text) {
  return Container(
    alignment: Alignment.topLeft,
    padding: const EdgeInsets.only(
      left: 5,
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
