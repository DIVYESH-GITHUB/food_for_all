import 'package:flutter/material.dart';
import 'package:food_for_all/get_states/loading.dart';
import 'package:food_for_all/screens/sign_up_screen.dart';
import 'package:food_for_all/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/firebase/sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final controller = Get.put(Loading());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
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
                const SizedBox(
                  height: 30,
                ),
                textField(
                  _email,
                  'Email',
                  const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                textField(
                  _password,
                  'Password',
                  const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                      controller.changeLoadingTrue();
                      SignIn().validate(
                        _email.text.trim().toString(),
                        _password.text.trim().toString(),
                      );
                      controller.changeLoadingFalse();
                    },
                    child: Obx(
                      () => controller.isLoading.value == true
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : ListTile(
                              trailing: const Icon(
                                Icons.arrow_forward,
                              ),
                              title: Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.25,
                                ),
                                child: Text(
                                  'Sign In',
                                  style: GoogleFonts.abyssinicaSil(
                                    fontSize: 20,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
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
            ),
          ),
        ),
      ),
    );
  }
}
