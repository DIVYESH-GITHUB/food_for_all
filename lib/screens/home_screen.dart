// ignore_for_file: avoid_print

import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_for_all/get_states/user_home_navigator.dart';
import 'package:food_for_all/screens/auth_screens/sign_in_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch_plus/toggle_switch_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  Future _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    File? img = File(image.path);
    setState(() {
      _image = img;
    });
  }

  final _auth = FirebaseAuth.instance;
  String date =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  String time =
      '${TimeOfDay.now().hour} : ${TimeOfDay.now().minute} ${TimeOfDay.now().period.name}';
  String foodType = 'Veg';
  final indexController = Get.put(UserHomeNavigator());
  final TextEditingController _description = TextEditingController();
  final TextEditingController _totalPerson = TextEditingController();
  final TextEditingController _foodSource = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    setState(() {
      date = '${pickedDate?.year}-${pickedDate?.month}-${pickedDate?.day}';
    });
  }

  Future<void> _selectedTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      time =
          '${pickedTime?.hour} : ${pickedTime?.minute} ${pickedTime?.period.name}';
    });
  }

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
      body: Obx(
        () => indexController.index.value == 0
            ? const Text('main page')
            : indexController.index.value == 1
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Food description'),
                          TextField(
                            controller: _description,
                            maxLines: 2,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade300,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                          const Text('Prepartion Date'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(date),
                              SizedBox(
                                width: 50,
                                child: IconButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Text('Prepartion Time'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(time),
                              SizedBox(
                                width: 50,
                                child: IconButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    _selectedTime(context);
                                  },
                                  icon: const Icon(Icons.timer),
                                ),
                              ),
                            ],
                          ),
                          const Text('Total person can be feeded : '),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: _totalPerson,
                            decoration: InputDecoration(
                              hintText: 'min. 10 person',
                              fillColor: Colors.grey.shade300,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                          const Text('Select Food type'),
                          ToggleSwitchPlus(
                            values: const [
                              'Veg',
                              'Non-veg',
                            ],
                            onChanged: (value) {
                              setState(() {
                                foodType = value;
                              });
                              print(foodType);
                            },
                            initialValue: 'Veg',
                            cornerRadius: 12,
                          ),
                          const Text('Select Food source'),
                          CustomDropdown(
                            items: const [
                              'Marriage Function',
                              'family gathering',
                              'Hostel mess',
                              'Other mess',
                              'freshly prepared',
                              'hello',
                            ],
                            controller: _foodSource,
                            fillColor: Colors.grey.shade300,
                          ),
                          const Text('Food image if Any : '),
                        ],
                      ),
                    ),
                  )
                : const Text('profile'),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(
          milliseconds: 200,
        ),
        buttonBackgroundColor: Colors.blue,
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.add_box,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.white,
        color: Colors.grey,
        height: 54,
        onTap: (value) {
          indexController.index.value = value;
        },
      ),
    );
  }
}
