import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_for_all/models/ngo_model_new.dart';
import 'package:food_for_all/screens/verify_screens/ngo_email_verification_screen.dart';
import 'package:get/get.dart';
import '../../widgets/snack_bar.dart';

class NgoSignUp {

  NgoModel ngoModel;
  String password;
  NgoSignUp({
    required this.ngoModel,
    required this.password,
  });
  final _auth = FirebaseAuth.instance;

  signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: ngoModel.email.toString(),
        password: password,
      );
      Get.to(
        NgoEmailVerificationScreen(
          ngoModel: ngoModel,
        ),
      );
    } on FirebaseAuthException catch (e) {
      snackBar('SIGN UP ERROR', e.message.toString());
    } catch (e) {
      snackBar('SIGN UP ERROR', e.toString());
    }
  }

  validate() {
    final ngoData = ngoModel.toMap();
    if (ngoData['name'].isEmpty ||
        ngoData['email'].isEmpty ||
        password.isEmpty ||
        ngoData['mobileNumber'].isEmpty ||
        ngoData['ngoType'].isEmpty ||
        ngoData['ngoAddress'].isEmpty ||
        ngoData['ngoCountry'] == 'null' ||
        ngoData['ngoState'] == 'null' ||
        ngoData['ngoCity'] == 'null') {
      snackBar("SIGN UP ERROR", 'some of the fields are empty');
      return;
    }

    if (!RegExp(r"^[a-z A-Z]+$").hasMatch(ngoData['name'])) {
      snackBar("SIGN UP ERROR", "please enter a valid name");
      return;
    }
    if (password.length < 6) {
      snackBar("SIGN UP ERROR", "PASSWORD LENGTH MUST BE ATLEAST 6");
      return;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(ngoData['email'])) {
      snackBar("SIGN UP ERROR", "Please enter a valid email");
      return;
    }
    if (!RegExp(r"^(\+?\d[\d -]{8,12}\d)").hasMatch(ngoData['mobileNumber'])) {
      snackBar("SIGN UP ERROR", "Please enter a valid mobile number");
      return;
    }
    signUp();
  }
}
