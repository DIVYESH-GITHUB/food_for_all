// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_for_all/models/user_model.dart';
import 'package:food_for_all/screens/auth_screens/sign_up_screen.dart';
import 'package:food_for_all/screens/complete_profile_screen.dart';
import 'package:get/get.dart';

class UserEmailVerificationScreen extends StatefulWidget {
  UserModel userModel;
  UserEmailVerificationScreen({
    super.key,
    required this.userModel,
  });

  @override
  State<UserEmailVerificationScreen> createState() =>
      _UserEmailVerificationScreen();
}

class _UserEmailVerificationScreen extends State<UserEmailVerificationScreen> {
  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  Timer? timer;
  int timeOut = 30;
  @override
  void initState() {
    final user = _auth.currentUser;
    user?.sendEmailVerification();
    timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (timer) async {
        setState(() {
          timeOut--;
        });
        if (timeOut == 0) {
          _auth.signOut();
          _auth.currentUser?.delete();
          Get.to(const SignUpScreen());
        }
        final user = _auth.currentUser;
        await user?.reload();
        if (user!.emailVerified) {
          timer.cancel();
          widget.userModel.emailVerified = true;
          db
              .collection('users')
              .doc(widget.userModel.email)
              .set(widget.userModel.toMap());
          Get.off(
            CompleteProfileScreen(
              userModel: widget.userModel,
            ),
          );
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
