import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_for_all/get_states/loading.dart';
import 'package:food_for_all/models/user_model.dart';
import 'package:food_for_all/screens/auth_screens/ngo_sign_up_screen.dart';
import 'package:food_for_all/screens/auth_screens/sign_in_screen.dart';
import 'package:food_for_all/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../auth/firebase/login & signup/user_sign_up.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  UserModel userModel = UserModel();
  final loadingController = Get.put(Loading());

  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    FirebaseAuth.instance.currentUser?.reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.06,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.04,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/logo-white.png',
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                SizedBox(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(
                        3,
                      ),
                      shadowColor: const MaterialStatePropertyAll(
                        Colors.white,
                      ),
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
                    onPressed: () {
                      Get.to(const NgoSignUpScreen());
                    },
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
                  const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  TextInputType.name,
                  false,
                ),
                const SizedBox(
                  height: 14,
                ),
                textField(
                  _email,
                  'Email',
                  const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  TextInputType.emailAddress,
                  false,
                ),
                const SizedBox(
                  height: 14,
                ),
                textField(
                  _password,
                  'Password',
                  const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  TextInputType.text,
                  true,
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(
                        3,
                      ),
                      shadowColor: const MaterialStatePropertyAll(
                        Colors.white,
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      loadingController.changeLoadingTrue();
                      UserModel userModel = UserModel(
                        email: _email.text.trim(),
                        userName: _username.text.trim(),
                      );
                      UserSignUp(
                        userModel: userModel,
                        password: _password.text.trim(),
                      ).validate();
                    },
                    child: Obx(
                      () => loadingController.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
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
