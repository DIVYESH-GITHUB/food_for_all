// ignore_for_file: avoid_print, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_for_all/get_states/stepper.dart';
import 'package:get/get.dart';

class NgoSignUpScreen extends StatefulWidget {
  const NgoSignUpScreen({super.key});

  @override
  State<NgoSignUpScreen> createState() => _NgoSignUpScreenState();
}

class _NgoSignUpScreenState extends State<NgoSignUpScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  String? countryValue;
  String? stateValue;
  String? cityValue;
  _NgoSignUpScreenState() {
    _selectedItem = items[0];
  }
  final List<String> items = [
    'Private',
    'Government',
    'Semi-government',
  ];
  String? _selectedItem = '';
  final controller = Get.put(StepperController());
  List<Step> stepList() {
    return [
      Step(
        title: const Text(
          'Basic Information',
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                  left: 5,
                ),
                child: const Text(
                  'NGO name',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: _name,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey.withOpacity(
                    0.4,
                  ),
                  hintText: 'Enter the NGO name',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                  left: 5,
                ),
                child: const Text(
                  'NGO email',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: true,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey.withOpacity(
                    0.4,
                  ),
                  hintText: "Enter NGO's email",
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                  left: 5,
                ),
                child: const Text(
                  'NGO mobile No.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _mobileNumber,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey.withOpacity(
                    0.4,
                  ),
                  hintText: "Enter NGO's mobile Number",
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                  left: 5,
                ),
                child: const Text(
                  'NGO type',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                icon: const Icon(
                  Icons.arrow_drop_down_circle,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(),
                  fillColor: Colors.grey.withOpacity(
                    0.4,
                  ),
                  filled: true,
                ),
                value: _selectedItem,
                items: items
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value;
                  });
                },
              ),
            ],
          ),
        ),
        isActive: controller.currentStep.value >= 0,
        state: controller.currentStep.value > 0
            ? StepState.complete
            : StepState.indexed,
      ),
      Step(
        title: const Text(
          'ADDRESS',
        ),
        content: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                left: 5,
              ),
              child: const Text(
                'Address',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _address,
              keyboardType: TextInputType.streetAddress,
              maxLines: 7,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.grey.withOpacity(
                  0.4,
                ),
                hintText: "Enter NGO's address",
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: SelectState(
                onCountryChanged: (value) {
                  countryValue = value;
                  setState(() {});
                },
                onStateChanged: (value) {
                  stateValue = value;
                  setState(() {});
                },
                onCityChanged: (value) {
                  cityValue = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        isActive: controller.currentStep.value >= 1,
        state: controller.currentStep.value > 1
            ? StepState.complete
            : StepState.indexed,
      ),
      Step(
        title: const Text(
          'Confirm',
        ),
        content: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(
            left: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please confirm your filled details : ',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('NGO name : ${_name.text}'),
              Text('NGO email : ${_email.text}'),
              Text('Mobile No: ${_mobileNumber.text}'),
              Text('NGO type : $_selectedItem'),
              const Text('NGO address : '),
              Text('${_address.text}'),
              Text('Country : ${countryValue}'),
              Text('State : ${stateValue}'),
              Text('City : ${cityValue}'),
            ],
          ),
        ),
        isActive: controller.currentStep.value >= 2,
        state: controller.currentStep.value > 2
            ? StepState.complete
            : StepState.indexed,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NGO SIGN UP',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Stepper(
            physics: const PageScrollPhysics(),
            currentStep: controller.currentStep.value,
            steps: stepList(),
            onStepContinue: () {
              if (controller.currentStep.value == stepList().length - 1) {
                print('send data to sever');
              } else {
                controller.currentStep.value++;
              }
            },
            onStepCancel: () {
              if (controller.currentStep.value == 0) {
                null;
              } else {
                controller.currentStep.value--;
              }
            },
            onStepTapped: (value) {
              controller.currentStep.value = value;
            },
            controlsBuilder: (context, details) {
              if (controller.currentStep.value == 0) {
                return Row(
                  children: [
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: const Text(
                        'CONTINUE',
                      ),
                    ),
                  ],
                );
              }
              if (controller.currentStep.value == 2) {
                return Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        FirebaseDatabase.instance.ref('ngo').child('2').set({
                          'name': _name.text,
                          'email': _email.text,
                          'number': _mobileNumber.text,
                        });
                      },
                      child: const Text(
                        'SUBMIT',
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: details.onStepCancel,
                      child: const Text(
                        'PREVIOUS',
                      ),
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: const Text(
                      'CONTINUE',
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: details.onStepCancel,
                    child: const Text(
                      'PREVIOUS',
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
