import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_for_all/screens/auth_screens/sign_in_screen.dart';
import 'package:get/get.dart';

class NgoMessage extends StatefulWidget {
  final String? name;
  const NgoMessage({super.key, required this.name});

  @override
  State<NgoMessage> createState() => _NgoMessageState();
}

class _NgoMessageState extends State<NgoMessage> {
  int time = 500;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (timer) {
        setState(() {
          time--;
        });
        if (time == 0) {
          Get.off(const SignInScreen());
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NGO VERIFY PAGE'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            height: Get.height * 0.2,
            width: Get.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10,
              ),
              color: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('YOUR REGISTRATION FOR NGO'),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '${widget.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text('IS SUCCESSFUL YOU WILL BE ABLE TO SIGN IN '),
                const SizedBox(
                  height: 4,
                ),
                const Text('ONCE ADMIN VERFIY YOUR NGO')
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Redirecting to SignIn page in ',
                  style: TextStyle(
                    letterSpacing: 1.4,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${time}s',
                  style: const TextStyle(
                    letterSpacing: 1.4,
                    color: Colors.blue,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () => Get.off(const SignInScreen()),
              child: const Text(
                'Redirect to SignIn page in now ',
                style: TextStyle(
                    letterSpacing: 1.4, fontSize: 16, color: Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }
}
