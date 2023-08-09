// ignore_for_file: avoid_print, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:food_for_all/auth/firebase/login%20&%20signup/ngo_sign_up.dart';
import 'package:food_for_all/get_states/stepper.dart';
import 'package:food_for_all/models/ngo_model_new.dart';
import 'package:food_for_all/widgets/ngo_form_text.dart';
import 'package:food_for_all/widgets/ngo_text_field.dart';
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
  final TextEditingController _password = TextEditingController();
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
              ngoFormText('NGO name'),
              const SizedBox(
                height: 8,
              ),
              ngoTextField(
                  'Enter the NGO name', _name, TextInputType.name, false, 1),
              const SizedBox(
                height: 10,
              ),
              ngoFormText("NGO email"),
              const SizedBox(
                height: 8,
              ),
              ngoTextField("Enter NGO's email", _email,
                  TextInputType.emailAddress, false, 1),
              const SizedBox(
                height: 14,
              ),
              ngoFormText('Password'),
              const SizedBox(
                height: 8,
              ),
              ngoTextField(
                  "Enter password", _password, TextInputType.text, true, 1),
              const SizedBox(
                height: 10,
              ),
              ngoFormText("NGO mobile No."),
              const SizedBox(
                height: 8,
              ),
              ngoTextField("Enter NGO's mobile Number", _mobileNumber,
                  TextInputType.phone, false, 1),
              const SizedBox(
                height: 10,
              ),
              ngoFormText('NGO type'),
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
              space(),
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
            ngoFormText('Address'),
            const SizedBox(
              height: 8,
            ),
            ngoTextField("Enter NGO's address", _address,
                TextInputType.streetAddress, false, 5),
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
              space(),
              Text(
                'NGO name :- ${_name.text}',
                style: textStyle(),
              ),
              space(),
              Text(
                'NGO email :- ${_email.text}',
                style: textStyle(),
              ),
              space(),
              Text(
                'Mobile No:- ${_mobileNumber.text}',
                style: textStyle(),
              ),
              space(),
              Text(
                'NGO type :- $_selectedItem',
                style: textStyle(),
              ),
              space(),
              Text(
                'NGO address :- ',
                style: textStyle(),
              ),
              space(),
              Text(
                '${_address.text}',
                style: textStyle(),
              ),
              space(),
              Text(
                'Country :- ${countryValue}',
                style: textStyle(),
              ),
              space(),
              Text(
                'State :- ${stateValue}',
                style: textStyle(),
              ),
              space(),
              Text(
                'City :- ${cityValue}',
                style: textStyle(),
              ),
              space(),
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

  textStyle() {
    return const TextStyle(
      fontSize: 16,
    );
  }

  space() {
    return const SizedBox(
      height: 3,
    );
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
                null;
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
              } else if (controller.currentStep.value == 2) {
                return Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        NgoModel ngoModel = NgoModel(
                          email: _email.text,
                          mobileNumber: _mobileNumber.text,
                          name: _name.text,
                          ngoAddress: _address.text,
                          ngoCity: cityValue.toString(),
                          ngoCountry: countryValue.toString(),
                          ngoState: stateValue.toString(),
                          ngoType: _selectedItem.toString(),
                        );
                        NgoSignUp(
                          ngoModel: ngoModel,
                          password: _password.text.trim(),
                        ).validate();
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
              } else {
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
              }
            },
          ),
        ),
      ),
    );
  }
}
