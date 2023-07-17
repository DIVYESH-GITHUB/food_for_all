import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class NgoRequestScreen extends StatefulWidget {
  const NgoRequestScreen({super.key});

  @override
  State<NgoRequestScreen> createState() => _NgoRequestScreenState();
}

class _NgoRequestScreenState extends State<NgoRequestScreen> {
  final _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('all-ngo');
  final ref2 = FirebaseDatabase.instance.ref('verified-ngo');
  final ref3 = FirebaseDatabase.instance.ref('non-verified-ngo');
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ALL NGO REQUEST'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                final ngo = snapshot.value as Map;
                return Card(
                  elevation: 3,
                  color: Colors.grey.shade200,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            '${ngo['name']}',
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        height(),
                        Text(
                          'Email : ${ngo['email']}',
                        ),
                        height(),
                        Text(
                          'Name : ${ngo['name']}',
                        ),
                        height(),
                        Text(
                          'mobile No. : ${ngo['mobileNumber']}',
                        ),
                        height(),
                        Text(
                          'Email : ${ngo['email']}',
                        ),
                        height(),
                        Text(
                          'ngoType : ${ngo['ngoType']}',
                        ),
                        height(),
                        Text(
                          'ngoAddress : ${ngo['ngoAddress']}',
                        ),
                        height(),
                        Text(
                          'ngoCountry : ${ngo['ngoCountry']}',
                        ),
                        height(),
                        Text(
                          'ngoState : ${ngo['ngoState']}',
                        ),
                        height(),
                        Text(
                          'ngoCity : ${ngo['ngoCity']}',
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Colors.green,
                                ),
                              ),
                              onPressed: () {
                                _auth.createUserWithEmailAndPassword(
                                  email: ngo['email'],
                                  password: ngo['password'],
                                );
                                ngo.remove('password');
                                ref2.child(ngo['name']).set(ngo);
                                ref.child(ngo['name']).remove();
                              },
                              child: const Text(
                                'Verify',
                              ),
                            ),
                            ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Colors.red,
                                ),
                              ),
                              onPressed: () {
                                ngo.remove('password');
                                ref3.child(ngo['name']).set(ngo);
                                ref.child(ngo['name']).remove();
                              },
                              child: const Text(
                                'Reject',
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  SizedBox height() {
    return const SizedBox(
      height: 3,
    );
  }
}
