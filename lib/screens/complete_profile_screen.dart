// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_for_all/models/user_model.dart';
import 'package:food_for_all/screens/user/home_screen.dart';
import 'package:food_for_all/widgets/snack_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch_plus/toggle_switch_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class CompleteProfileScreen extends StatefulWidget {
  UserModel userModel;
  CompleteProfileScreen({
    super.key,
    required this.userModel,
  });

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final db = FirebaseFirestore.instance;
  //    IMAGE VARIABLE
  File? _image;

  //    CONTROLLER
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _middleName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  String gender = 'Male';

  //  FUNCTIONS FOR GETTING LOCATION FROM LONGITUDE & LATITUDE
  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    setState(() {
      _address.text = '${place.country}, ${place.name}, ${place.postalCode}';
    });
  }

  //  FUNCTIONS TO GET LONGITUDE & LATITUDE
  Future<Position> _determinePosition() async {
    return await Geolocator.getCurrentPosition();
  }

  //  FUNCTION TO CHECK IF LOCATION IS ENABLED OR NOT
  Future<int> checkLocationEnabled() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      await Geolocator.openLocationSettings();
      if (!isLocationEnabled) {
        return 0;
      }
    }
    return 1;
  }

  // FUNCTION TO CHECK IF LOCATION PERMISSIONS ARE GRENTED OR NOT
  Future<int> locationPermission() async {
    PermissionStatus locationPermissionStatus =
        await Permission.location.request();
    if (locationPermissionStatus == PermissionStatus.granted) {
      return 1;
    } else if (locationPermissionStatus == PermissionStatus.denied) {
      return 0;
    } else if (locationPermissionStatus == PermissionStatus.permanentlyDenied) {
      return 0;
    }
    return 0;
  }

  //  FUNCTION FOR PICKING IMAGE
  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final tempImage = File(image.path);
    setState(() {
      _image = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 23,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadiusDirectional.circular(
              10,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      _image == null
                          ? const CircleAvatar(
                              radius: 65,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    AssetImage('assets/images/logo-white.png'),
                              ),
                            )
                          : CircleAvatar(
                              radius: 65,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(_image!),
                              ),
                            ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 8,
                        ),
                        width: 35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          iconSize: 20,
                          onPressed: () {
                            bottomSheet();
                          },
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'First name',
                ),
                textField(_firstName, TextInputType.name),
                const SizedBox(
                  height: 27,
                ),
                const Text(
                  'Middle name',
                ),
                textField(_middleName, TextInputType.name),
                const SizedBox(
                  height: 27,
                ),
                const Text(
                  'Last name',
                ),
                textField(_lastName, TextInputType.name),
                const SizedBox(
                  height: 27,
                ),
                const Text(
                  'Mobile Number',
                ),
                textField(_mobileNumber, TextInputType.number),
                const SizedBox(
                  height: 27,
                ),
                const Text(
                  'Gender',
                ),
                const SizedBox(
                  height: 12,
                ),
                ToggleSwitchPlus(
                  values: const [
                    'Male',
                    'Female',
                  ],
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                  initialValue: gender,
                  cornerRadius: 10,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Address',
                ),
                textField(_address, TextInputType.text),
                const SizedBox(
                  height: 7,
                ),
                const Center(child: Text('OR')),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (await checkLocationEnabled() == 1) {
                        if (await locationPermission() == 0) {
                          await snackBar('LOCATION ERROR',
                              'please grant permission to use this feature');
                        } else {
                          Position position = await _determinePosition();
                          await getAddressFromLatLong(position);
                        }
                      }
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on_outlined),
                        Text(
                          'Get current location',
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.green,
                      ),
                    ),
                    onPressed: () async {
                      final ref = FirebaseStorage.instance
                          .ref()
                          .child('user images')
                          .child('${widget.userModel.email}.jpg');
                      UploadTask uploadTask = ref.putFile(File(_image!.path));
                      final snapshot =
                          await uploadTask.whenComplete(() => null);
                      String url = await snapshot.ref.getDownloadURL();
                      var userModel = widget.userModel;
                      userModel.firstName = _firstName.text.trim();
                      userModel.middleName = _middleName.text.trim();
                      userModel.lastName = _lastName.text.trim();
                      userModel.mobileNumber = _mobileNumber.text.trim();
                      userModel.gender = gender;
                      userModel.address = _address.text.trim();
                      userModel.url = url;
                      db
                          .collection('users')
                          .doc(widget.userModel.email)
                          .update(widget.userModel.toMap());
                      Get.off(const HomeScreen());
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Continue'),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SHOW BOTTOM SHEET ON PRESSED OF IMAGE SELECT BUTTON
  bottomSheet() {
    return showModalBottomSheet(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Pick A option for image',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera,
                    ),
                    Text(
                      'Camera',
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                    ),
                    Text(
                      'Gallery',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //  LOCAL TEXT FIELD FOR THIS PAGES ONLY
  TextField textField(
    TextEditingController controller,
    TextInputType textInputType,
  ) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      decoration: const InputDecoration(
        isDense: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
