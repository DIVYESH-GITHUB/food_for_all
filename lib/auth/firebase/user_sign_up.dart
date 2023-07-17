import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_for_all/auth/firebase/store_user_data.dart';
import 'package:food_for_all/get_states/loading.dart';
import 'package:food_for_all/models/user_model.dart';
import 'package:food_for_all/widgets/snack_bar.dart';
import 'package:get/get.dart';

import '../../screens/verify_screens/user_email_verification_screen.dart';

class UserSignUp {
  final controller = Get.put(Loading());
  final _auth = FirebaseAuth.instance;

  signUp(String email, String password, String username) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userData =
          UserModel(email: email, name: username, uid: _auth.currentUser?.uid)
              .toMap();
      StoreUserData(userData: userData).allUSers();
      Get.to(UserEmailVerificationScreen(
        userData: userData,
      ));
      controller.changeLoadingFalse();
    } on FirebaseAuthException catch (e) {
      controller.changeLoadingFalse();
      snackBar('SIGN UP ERROR', e.message.toString());
    } catch (e) {
      controller.changeLoadingFalse();
      snackBar('SIGN UP ERROR', e.toString());
    }
  }

  validate(String username, String email, String password) {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      snackBar('SIGN UP ERROR', 'Some Of The Fields Are Empty');
      controller.changeLoadingFalse();
    } else {
      signUp(email, password, username);
    }
  }
}
