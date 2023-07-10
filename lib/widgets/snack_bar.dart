import 'package:flutter/material.dart';
import 'package:get/get.dart';

snackBar(String title, String message) {
  return Get.snackbar(
    snackPosition: SnackPosition.TOP,
    title,
    '',
    backgroundColor: Colors.red,
    colorText: Colors.white,
    icon: const Icon(Icons.error),
    isDismissible: true,
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );
}
