import 'package:flutter/material.dart';
import 'package:get/get.dart';

snackBar(String title, String message) {
  return Get.snackbar(
        snackPosition: SnackPosition.TOP,
        title,
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error),
        isDismissible: true,
      );
}
