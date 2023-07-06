import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_for_all/auth/firebase/store_user_data.dart';
import 'package:food_for_all/get_states/loading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../screens/email_verification.dart';

class SignUp {

  final contoller = Get.put(Loading());
  final _auth = FirebaseAuth.instance;

  signUp(String email, String password, String username) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      StoreUserData().allUSers(email, username);
      Get.to(EmailVerificationScreen(
        email: email,
        username: username,
      ));
    } on FirebaseAuthException catch (e) {
      contoller.changeLoadingFalse();
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "SIGN UP ERROR",
        e.code.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error),
        isDismissible: true,
      );
    } catch (e) {
      contoller.changeLoadingFalse();
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "SIGN UP ERROR",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error),
        isDismissible: true,
      );
    }
  }

  validate(String username, String email, String password) {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "SIGN UP ERROR",
        '',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error),
        isDismissible: true,
        messageText: const Text(
          'Some of the fields are empty !',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      );
      contoller.changeLoadingFalse();
    } else {
      signUp(email, password, username);
    }
  }
}
