// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_for_all/models/ngo_model_new.dart';
import 'package:food_for_all/screens/verify_screens/ngo_message.dart';
import 'package:get/get.dart';

class NgoEmailVerificationScreen extends StatefulWidget {
  NgoModel ngoModel;
  NgoEmailVerificationScreen({
    super.key,
    required this.ngoModel,
  });

  @override
  State<NgoEmailVerificationScreen> createState() =>
      _NgoEmailVerificationScreen();
}

class _NgoEmailVerificationScreen extends State<NgoEmailVerificationScreen> {
  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  Timer? timer;
  @override
  void initState() {
    final user = _auth.currentUser;
    user?.sendEmailVerification();
    timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (timer) async {
        final user = _auth.currentUser;
        await user?.reload();
        if (user!.emailVerified) {
          timer.cancel();
          widget.ngoModel.emailVerified = true;
          db
              .collection('ngo')
              .doc(widget.ngoModel.email)
              .set(widget.ngoModel.toMap());
          Get.off(
            NgoMessage(
              name: widget.ngoModel.name,
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
