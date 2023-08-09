import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch_plus/toggle_switch_plus.dart';

class EditProflePage extends StatefulWidget {
  const EditProflePage({super.key});

  @override
  State<EditProflePage> createState() => _EditProflePageState();
}

class _EditProflePageState extends State<EditProflePage> {
  Map<String, dynamic>? userDetails;
  @override
  Widget build(BuildContext context) {
    final TextEditingController userName = TextEditingController();
    final TextEditingController firstName = TextEditingController();
    final TextEditingController middleName = TextEditingController();
    final TextEditingController lastName = TextEditingController();

    final TextEditingController address = TextEditingController();

    String gender = 'Male';
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(
            left: 12,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
        ),
        title: Text(
          'Edit profile',
          style: TextStyle(
            shadows: [
              Shadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 5,
              )
            ],
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc('divyeshpindaria09@gmail.com')
              .get(),
          builder: (context, snapshot) {
            userDetails = snapshot.data?.data();
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 15,
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                blurStyle: BlurStyle.normal,
                                spreadRadius: 2,
                                blurRadius: 6,
                              )
                            ],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/logo-white.png',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 33,
                          height: 33,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              size: 20,
                              Icons.edit,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  text('username'),
                  textField(1, userName),
                  const SizedBox(
                    height: 14,
                  ),
                  text('First name'),
                  textField(1, firstName),
                  const SizedBox(
                    height: 14,
                  ),
                  text('Middle name'),
                  textField(1, middleName),
                  const SizedBox(
                    height: 14,
                  ),
                  text('Last name'),
                  textField(1, lastName),
                  const SizedBox(
                    height: 14,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  text('Gender'),
                  const SizedBox(
                    height: 14,
                  ),
                  ToggleSwitchPlus(
                    selectedBackgroundColor: Colors.blue,
                    unselectedBackgroundColor: Colors.grey.shade700,
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
                    height: 8,
                  ),
                  text('Address'),
                  textField(2, address),
                  const SizedBox(
                    height: 14,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        style: const ButtonStyle(
                          shadowColor: MaterialStatePropertyAll(Colors.white),
                          elevation: MaterialStatePropertyAll(3),
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.red,
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.cancel,
                        ),
                        label: const Text(
                          'Cancel',
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ElevatedButton.icon(
                        style: const ButtonStyle(
                          shadowColor: MaterialStatePropertyAll(Colors.white),
                          elevation: MaterialStatePropertyAll(3),
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.green,
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.done,
                        ),
                        label: const Text(
                          'Confirm',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }

  Text text(String field) {
    return Text(
      field,
      style: const TextStyle(
        color: Colors.green,
        fontSize: 18,
      ),
    );
  }

  TextField textField(
      int maxLines, TextEditingController textEditingController) {
    return TextField(
      controller: textEditingController,
      maxLines: maxLines,
      decoration: const InputDecoration(
        isDense: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
