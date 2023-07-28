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

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final tempImage = File(image.path);
    setState(() {
      _image = tempImage;
    });
  }

  final _auth = FirebaseAuth.instance;

  bool isOther = false;
  String date =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  String time =
      '${TimeOfDay.now().hour} : ${TimeOfDay.now().minute} ${TimeOfDay.now().period.name}';
  String foodType = 'Veg';
  final indexController = Get.put(UserHomeNavigator());
  final TextEditingController _description = TextEditingController();
  final TextEditingController _totalPerson = TextEditingController();
  final TextEditingController _foodSource = TextEditingController();
  final TextEditingController _weight = TextEditingController();

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
                ? addFood()
                : const Center(
                    child: Text("hello"),
                  ),
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

  addFood() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text('Food description'),
            height4(),
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
            height6(),
            text('Preparation Date'),
            height4(),
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
            height6(),
            text('Prepartion Time'),
            height4(),
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
            height6(),
            text('Total person can be feeded'),
            height4(),
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
            height6(),
            text('Food weight'),
            height4(),
            TextField(
              keyboardType: TextInputType.number,
              controller: _weight,
              decoration: InputDecoration(
                hintText: 'Food weigth in Kg',
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
            height6(),
            text('Select food type'),
            height6(),
            ToggleSwitchPlus(
              values: const [
                'Veg',
                'Non-veg',
              ],
              onChanged: (value) {
                setState(() {
                  foodType = value;
                });
              },
              initialValue: 'Veg',
              cornerRadius: 12,
            ),
            height6(),
            text('Select food source'),
            height4(),
            CustomDropdown(
              items: const [
                'Marriage Function',
                'family gathering',
                'Hostel mess',
                'Other mess',
                'freshly prepared',
                'Other'
              ],
              controller: _foodSource,
              onChanged: (p0) {
                if (p0 == 'Other') {
                  setState(() {
                    isOther = true;
                  });
                } else {
                  setState(() {
                    isOther = false;
                  });
                }
              },
              fillColor: Colors.grey.shade300,
              hintText: 'Food Source',
              hintStyle: const TextStyle(
                color: Colors.black45,
              ),
            ),
            height6(),
            isOther == true
                ? TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter food source',
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
                  )
                : const Center(),
            height6(),
            text('Add Food image'),
            height6(),
            _image == null
                ? Center(
                    child: ElevatedButton(
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.camera,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text('Add Image'),
                        ],
                      ),
                      onPressed: () {
                        getImage(
                          ImageSource.camera,
                        );
                      },
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                    ),
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                              icon: const Icon(
                                Icons.cancel_outlined,
                              ),
                            ),
                          ],
                        ),
                        Image.file(
                          _image!,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  text(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
      ),
    );
  }

  height4() {
    return const SizedBox(
      height: 4,
    );
  }

  height6() {
    return const SizedBox(
      height: 6,
    );
  }
}
