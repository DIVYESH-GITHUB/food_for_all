import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_for_all/get_states/loading.dart';
import 'package:food_for_all/models/user_model.dart';
import 'package:food_for_all/screens/verify_screens/user_email_verification_screen.dart';
import 'package:food_for_all/widgets/snack_bar.dart';
import 'package:get/get.dart';

class UserSignUp {
  UserModel userModel;
  String password;
  UserSignUp({
    required this.userModel,
    required this.password,
  });
  final controller = Get.put(Loading());
  final _auth = FirebaseAuth.instance;

  signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: userModel.email.toString(),
        password: password,
      );
      controller.changeLoadingFalse();
      Get.to(
        UserEmailVerificationScreen(
          userModel: userModel,
        ),
      );
    } on FirebaseAuthException catch (e) {
      controller.changeLoadingFalse();
      snackBar('SIGN UP ERROR', e.message.toString());
    } catch (e) {
      controller.changeLoadingFalse();
      snackBar('SIGN UP ERROR', e.toString());
    }
  }

  validate(String password) {
    if (userModel.userName!.isEmpty ||
        userModel.email!.isEmpty ||
        password.isEmpty) {
      snackBar('SIGN UP ERROR', 'Some Of The Fields Are Empty');
      controller.changeLoadingFalse();
    } else {
      signUp();
    }
  }
}
