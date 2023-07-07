import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_for_all/screens/sign_in_screen.dart';
import 'package:get/get.dart';

class NgoVerifyScreen extends StatefulWidget {
  final String? name;
  const NgoVerifyScreen({super.key, this.name});

  @override
  State<NgoVerifyScreen> createState() => _NgoVerifyScreenState();
}

class _NgoVerifyScreenState extends State<NgoVerifyScreen> {
  int time = 10;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
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
                  const Text('IS SUCCESSFUL YOU WILL BE ABLE TO SIGN IN ONCE '),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text('ADMIN VERFIY YOUR NGO')
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
                    ),
                  ),
                  Text(
                    '${time}s',
                    style: const TextStyle(
                      letterSpacing: 1.4,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
