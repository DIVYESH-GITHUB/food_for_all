import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  //    IMAGE VARIABLE
  File? _image;

  //    CONTROLLER
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _address = TextEditingController();

  //  LOCATION FUNCTIONS - 1
  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    setState(() {
      _address.text = '${place.country}, ${place.name}, ${place.postalCode}';
    });
  }

  //  LOCATION FUNCTIONS - 2
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
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
                  height: 25,
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 70,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundImage:
                              AssetImage('assets/images/logo-white.png'),
                        ),
                      ),
                      Container(
                        width: 35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          iconSize: 20,
                          onPressed: () {
                            showModalBottomSheet(
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
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                  'Full name',
                ),
                textField(_fullName, TextInputType.name),
                const SizedBox(
                  height: 17,
                ),
                const Text(
                  'Age',
                ),
                textField(_age, TextInputType.number),
                const SizedBox(
                  height: 17,
                ),
                const Text('Gender'),
                const SizedBox(
                  height: 15,
                ),
                ToggleSwitch(
                  minWidth: 100,
                  labels: const [
                    'Male',
                    'Female',
                  ],
                  icons: const [
                    Icons.male,
                    Icons.female,
                  ],
                ),
                const SizedBox(
                  height: 20,
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
                      Position position = await _determinePosition();
                      await getAddressFromLatLong(position);
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
              ],
            ),
          ),
        ),
      ),
    );
  }

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
