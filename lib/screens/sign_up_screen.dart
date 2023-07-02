import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_for_all/screens/email_verification.dart';
import 'package:food_for_all/screens/sign_in_screen.dart';
import 'package:food_for_all/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  validate() {
    final username = _username.text.trim().toString();
    final email = _email.text.trim().toString();
    final password = _password.text.trim().toString();
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
      setState(() {
        isLoading = false;
      });
    } else {
      signUp(
        _email.text.trim().toString(),
        _password.text.trim().toString(),
      );
    }
  }

  signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.to(const EmailVerificationScreen());
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
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
      setState(() {
        isLoading = false;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/logo-white.png',
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Colors.green,
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Register NGO',
                      style: GoogleFonts.abyssinicaSil(
                        fontSize: 20,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  'OR',
                  style: GoogleFonts.abyssinicaSil(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                textField(
                  _username,
                  'Username',
                ),
                const SizedBox(
                  height: 14,
                ),
                textField(
                  _email,
                  'Email',
                ),
                const SizedBox(
                  height: 14,
                ),
                textField(
                  _password,
                  'Password',
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      validate();
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                        : ListTile(
                            trailing: const Icon(
                              Icons.arrow_forward,
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 130,
                            ),
                            title: Text(
                              'Sign Up',
                              style: GoogleFonts.abyssinicaSil(
                                fontSize: 20,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.abyssinicaSil(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(const SignInScreen());
                      },
                      child: Text(
                        'SignIn',
                        style: GoogleFonts.abyssinicaSil(
                          color: Colors.green,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
