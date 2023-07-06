import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_for_all/auth/firebase/store_user_data.dart';
import 'package:food_for_all/screens/home_screen.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final String username;
  const EmailVerificationScreen(
      {super.key, required this.email, required this.username});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _auth = FirebaseAuth.instance;
  Timer? timer;
  @override
  void initState() {
    final user = _auth.currentUser;
    user!.sendEmailVerification();
    timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (timer) async {
        final user = _auth.currentUser;
        await user!.reload();
        if (user.emailVerified) {
          StoreUserData().verifiedUSer(widget.email, widget.username);
          timer.cancel();
          Get.off(const HomeScreen());
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 385,
          height: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Email is send to',
                style: TextStyle(fontSize: 19, letterSpacing: 1),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                '${_auth.currentUser?.email}',
                style: const TextStyle(
                  fontSize: 19,
                  letterSpacing: 1.1,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Text(
                'Please verify your Email...!',
                style: TextStyle(
                  fontSize: 19,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
