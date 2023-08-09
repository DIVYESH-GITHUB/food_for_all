import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_for_all/get_states/loading.dart';
import 'package:food_for_all/widgets/snack_bar.dart';
import 'package:get/get.dart';
import '../../../screens/user/home_screen.dart';

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
    final docRef = db.collection("users").doc(email);

    docRef.get().then(
      (DocumentSnapshot doc) async {
        if (doc.data() == null) {
          controller.changeLoadingFalse();
          snackBar('Sign in error', 'user doesnot exist');
          return;
        }
        final data = doc.data() as Map<String, dynamic>;
        if (data['emailVerified'] == true) {
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
            snackBar("SIGN IN ERROR", 'User doesnot exist');
          }
        }
      },
      onError: (e) {
        controller.changeLoadingFalse();
        snackBar('Sign in error', 'user doesnot exist');
        return;
      },
    );
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
