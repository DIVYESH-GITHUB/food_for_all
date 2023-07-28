import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_for_all/get_states/loading.dart';
import 'package:food_for_all/widgets/snack_bar.dart';
import 'package:get/get.dart';
import '../../screens/user/home_screen.dart';

class UserSignIn {
  String email;
  String password;
  UserSignIn({
    required this.email,
    required this.password,
  });
  final db = FirebaseFirestore.instance;
  final controller = Get.put(Loading());
  final _auth = FirebaseAuth.instance;
  signIn() async {
    try {
      DocumentSnapshot snapshot = await db.collection('users').doc(email).get();
      try {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        controller.changeLoadingFalse();
        Get.off(const HomeScreen());
      } on FirebaseAuthException {
        controller.changeLoadingFalse();
        snackBar("SIGN IN ERROR", 'User doesnot exist');
      } catch (e) {
        controller.changeLoadingFalse();
        snackBar("SIGN IN ERROR", 'User doesnot exist');
      }
    } catch (e) {
      controller.changeLoadingFalse();
      snackBar("SIGN IN ERROR", 'User doesnot exist');
    }
  }

  validate() {
    if (email.isEmpty || password.isEmpty) {
      controller.changeLoadingFalse();
      snackBar('SIGN IN ERROR', 'Some Of The Fields Are Empty');
    } else {
      signIn();
    }
  }
}
