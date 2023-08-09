// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:food_for_all/auth/firebase/login%20&%20signup/ngo_sign_in.dart';
import 'package:food_for_all/get_states/loading.dart';
import 'package:food_for_all/get_states/user_type.dart';
import 'package:food_for_all/screens/admin/all_ngo_request.dart';
import 'package:food_for_all/screens/auth_screens/sign_up_screen.dart';
import 'package:food_for_all/widgets/snack_bar.dart';
import 'package:food_for_all/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch_plus/toggle_switch_plus.dart';
import '../../auth/firebase/login & signup/user_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();
  final TextEditingController _ngoEmail = TextEditingController();
  final TextEditingController _ngoPassword = TextEditingController();
  final TextEditingController _adminName = TextEditingController();
  final TextEditingController _adminPassword = TextEditingController();
  final loadingController = Get.put(Loading());
  final userTypeController = Get.put(UserType());
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.15,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/logo-white.png',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Center(
                    child: ToggleSwitchPlus(
                      fontSize: 18,
                      cornerRadius: 10,
                      initialValue: userTypeController.userType.value,
                      values: const [
                        'user',
                        'NGO',
                        'admin',
                      ],
                      onChanged: (value) {
                        userTypeController.userType.value = value;
                      },
                      unselectedBackgroundColor: Colors.white,
                      unselectedForegroundColor: Colors.black,
                    ),
                  ),
                ),
                Obx(
                  () => userTypeController.userType.value == 'user'
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            textField(
                              _userEmail,
                              'Email',
                              const Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              TextInputType.emailAddress,
                              false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            textField(
                              _userPassword,
                              'Password',
                              const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              TextInputType.text,
                              true,
                            ),
                            const SizedBox(
                              height: 20,
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
                                  UserSignIn(
                                    email: _userEmail.text.trim(),
                                    password: _userPassword.text.trim(),
                                  ).validate();
                                },
                                child: loadingController.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Sign In',
                                        style: GoogleFonts.abyssinicaSil(
                                          fontSize: 20,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
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
                                    Get.offAll(
                                      const SignUpScreen(),
                                    );
                                  },
                                  child: Text(
                                    'SignUp',
                                    style: GoogleFonts.abyssinicaSil(
                                      color: Colors.green,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : userTypeController.userType.value == 'NGO'
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                textField(
                                  _ngoEmail,
                                  'Email',
                                  const Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  TextInputType.emailAddress,
                                  false,
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                textField(
                                  _ngoPassword,
                                  'Password',
                                  const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  TextInputType.text,
                                  true,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 55,
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: const MaterialStatePropertyAll(
                                        3,
                                      ),
                                      shadowColor:
                                          const MaterialStatePropertyAll(
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
                                      NgoSignIn().check(
                                        _ngoEmail.text.trim().toString(),
                                        _ngoPassword.text.trim().toString(),
                                      );
                                    },
                                    child: loadingController.isLoading.value
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            'Sign In',
                                            style: GoogleFonts.abyssinicaSil(
                                              fontSize: 20,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account?",
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
                                        Get.offAll(
                                          const SignUpScreen(),
                                        );
                                      },
                                      child: Text(
                                        'SignUp',
                                        style: GoogleFonts.abyssinicaSil(
                                          color: Colors.green,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                textField(
                                  _adminName,
                                  'Name',
                                  const Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  TextInputType.emailAddress,
                                  false,
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                textField(
                                  _adminPassword,
                                  'Password',
                                  const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  TextInputType.text,
                                  true,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 55,
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: const MaterialStatePropertyAll(
                                        3,
                                      ),
                                      shadowColor:
                                          const MaterialStatePropertyAll(
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
                                      if (_adminName.text == 'admin' &&
                                          _adminPassword.text == 'admin') {
                                        Get.off(const NgoRequestScreen());
                                      } else {
                                        snackBar(
                                          "SIGN IN ERROR",
                                          "WRONG CREDENTIAL",
                                        );
                                      }
                                      print(userTypeController.userType.value);
                                    },
                                    child: loadingController.isLoading.value
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            'Sign In',
                                            style: GoogleFonts.abyssinicaSil(
                                              fontSize: 20,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
