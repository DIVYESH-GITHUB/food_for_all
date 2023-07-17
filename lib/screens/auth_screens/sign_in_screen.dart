// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:food_for_all/auth/firebase/ngo_sign_in.dart';
import 'package:food_for_all/get_states/loading.dart';
import 'package:food_for_all/get_states/user_type.dart';
import 'package:food_for_all/screens/admin/all_ngo_request.dart';
import 'package:food_for_all/screens/auth_screens/sign_up_screen.dart';
import 'package:food_for_all/widgets/snack_bar.dart';
import 'package:food_for_all/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../auth/firebase/user_sign_in.dart';

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
              children: [
                SizedBox(
                  height: Get.height * 0.2,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/logo-white.png',
                  ),
                ),
                ToggleSwitch(
                  labels: const [
                    'user',
                    'NGO',
                    'admin',
                  ],
                  onToggle: (index) {
                    userTypeController.userType.value = index!;
                  },
                  fontSize: 18,
                  minWidth: 110,
                  icons: const [
                    Icons.person,
                    Icons.fastfood,
                    Icons.admin_panel_settings,
                  ],
                  iconSize: 20,
                  inactiveBgColor: Colors.white,
                ),
                Obx(
                  () => userTypeController.userType.value == 0
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
                                  UserSignIn().validate(
                                    _userEmail.text.trim().toString(),
                                    _userPassword.text.trim().toString(),
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
                      : userTypeController.userType.value == 1
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
