// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_for_all/screens/auth_screens/sign_in_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    print("rebuild.....!");
    print(_auth.currentUser);
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: GestureDetector(
              onTap: () async {
                await _auth.signOut();
                Get.off(const SignInScreen());
              },
              child: const Icon(
                Icons.logout_outlined,
              ),
            ),
          ),
        ],
        title: const Text(
          'Home Page',
        ),
        centerTitle: true,
      ),
    );
  }
}
