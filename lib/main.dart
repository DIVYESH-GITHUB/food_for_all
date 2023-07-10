// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_for_all/firebase_options.dart';
import 'package:food_for_all/screens/home_screen.dart';
import 'package:food_for_all/screens/auth_screens/sign_in_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(context) {
    reloadUser();
    return GetMaterialApp(
      home: _auth.currentUser?.emailVerified == true
          ? const HomeScreen()
          : const SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  reloadUser() async {
    await _auth.currentUser?.reload();
  }
}
