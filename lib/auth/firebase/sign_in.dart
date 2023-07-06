import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_for_all/get_states/loading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../screens/home_screen.dart';

class SignIn {
  final controller = Get.put(Loading());
  final _auth = FirebaseAuth.instance;
  signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar(
        '',
        '',
        titleText: const Center(
          child: Text(
            "SIGN IN SUCCESSFUL",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: Colors.green,
        isDismissible: true,
        borderColor: Colors.white,
        borderWidth: 5,
        icon: Container(
          padding: const EdgeInsets.only(
            left: 40,
          ),
          child: const Icon(
            Icons.thumb_up_sharp,
          ),
        ),
        shouldIconPulse: false,
      );
      controller.changeLoadingFalse();
      Get.off(const HomeScreen());
    } on FirebaseAuthException catch (e) {
      controller.changeLoadingFalse();
      Get.snackbar(
        "SIGN IN ERROR",
        e.code.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        isDismissible: true,
      );
    }
  }

  validate(String email, String password) {
    {
      if (email.isEmpty || password.isEmpty) {
        controller.changeLoadingFalse();
        Get.snackbar(
          'SIGN IN ERROR',
          "Some of the feilds are empty",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          isDismissible: true,
          icon: const Icon(Icons.error),
        );
      } else {
        signIn(email, password);
      }
    }
  }
}
