import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_for_all/get_states/loading.dart';
import 'package:food_for_all/widgets/snack_bar.dart';
import 'package:get/get.dart';
import '../../screens/home_screen.dart';

class UserSignIn {
  final controller = Get.put(Loading());
  final _auth = FirebaseAuth.instance;
  signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      controller.changeLoadingFalse();
      Get.off(const HomeScreen());
    } on FirebaseAuthException catch (e) {
      controller.changeLoadingFalse();
      snackBar("SIGN IN ERROR", e.message.toString());
    } catch (e) {
      controller.changeLoadingFalse();
      snackBar("SIGN IN ERROR", e.toString());
    }
  }

  validate(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      controller.changeLoadingFalse();
      snackBar('SIGN IN ERROR', 'Some Of The Fields Are Empty');
    } else {
      signIn(email, password);
    }
  }
}
