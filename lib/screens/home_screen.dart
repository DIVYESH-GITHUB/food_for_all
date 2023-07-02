// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print("rebuild.....!");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
        ),
        centerTitle: true,
      ),
    );
  }
}
