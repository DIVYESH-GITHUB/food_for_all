import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_for_all/auth/firebase/store_ngo_data.dart';
import 'package:food_for_all/widgets/snack_bar.dart';
import 'package:get/get.dart';
import '../../screens/ngo_verify_screen.dart';

class NgoSignUp {
  bool isValidated = true;
  final _auth = FirebaseAuth.instance;

  validate(
    String name,
    String email,
    String password,
    String mobileNumber,
    String ngoType,
    String ngoAddress,
    String ngoCountry,
    String ngoState,
    String ngoCity,
  ) {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        mobileNumber.isEmpty ||
        ngoType.isEmpty ||
        ngoCountry.isEmpty ||
        ngoState.isEmpty ||
        ngoCity.isEmpty ||
        ngoAddress.isEmpty) {
      snackBar("SIGN UP ERROR", 'some of the fields are empty');
      return;
    }

    if (!RegExp(r"^[a-z A-Z]+$").hasMatch(name)) {
      snackBar("SIGN UP ERROR", "please enter a valid name");
      return;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      snackBar("SIGN UP ERROR", "Please enter a valid email");
      return;
    }
    if (!RegExp(r"^(\+?\d[\d -]{8,12}\d)").hasMatch(mobileNumber)) {
      snackBar("SIGN UP ERROR", "Please enter a valid mobile number");
      return;
    }
    signUp(
      name,
      email,
      password,
      mobileNumber,
      ngoType,
      ngoAddress,
      ngoCountry,
      ngoState,
      ngoCity,
    );
  }

  signUp(
    String name,
    String email,
    String password,
    String mobileNumber,
    String ngoType,
    String ngoAddress,
    String ngoCountry,
    String ngoState,
    String ngoCity,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      snackBar('SIGN UP ERROR', e.message.toString());
    } catch (e) {
      snackBar("SIGN UP ERROR", "GENERAL ERROR");
    }
    StoreNgoData().storeAllNgoData(
      name,
      email,
      mobileNumber,
      ngoType,
      ngoAddress,
      ngoCountry,
      ngoState,
      ngoCity,
    );
    Get.off(NgoVerifyScreen(name: name));
  }
}
