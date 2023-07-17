// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_for_all/screens/ngo_home_screen.dart';
import 'package:food_for_all/widgets/snack_bar.dart';
import 'package:get/get.dart';

final ref = FirebaseDatabase.instance.ref('verified-ngo');
bool found = false;

class NgoSignIn {
  check(String email, String password) async {
    await ref.get().then(
      (value) {
        for (var element in value.children) {
          if (element.child('email').value == email) {
            found = true;
            break;
          }
        }
      },
    );
    if (found == true) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Get.off(const NgoHomeScreen());
      } on FirebaseAuthException catch (e) {
        snackBar(
          'SIGN IN ERROR',
          e.message.toString(),
        );
      }
    } else {
      snackBar("SIGN IN ERROR", "Ngo doesn't exists");
    }
  }
}
