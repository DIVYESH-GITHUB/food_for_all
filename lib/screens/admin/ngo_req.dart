import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NgoRequests extends StatefulWidget {
  const NgoRequests({super.key});

  @override
  State<NgoRequests> createState() => _NgoRequestsState();
}

class _NgoRequestsState extends State<NgoRequests> {
  final _ngoStream = FirebaseFirestore.instance.collection('ngo').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All ngo request'),
      ),
      body: StreamBuilder(
        stream: _ngoStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Connection error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading...');
          }
          var docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              if (docs[index]['isVerified'] == null) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          '${docs[index]['name']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('Name : ${docs[index]['name']}'),
                      height3(),
                      Text('mobile number : ${docs[index]['mobileNumber']}'),
                      height3(),
                      Text('email : ${docs[index]['email']}'),
                      height3(),
                      Text('address : ${docs[index]['ngoAddress']}'),
                      height3(),
                      Text('ngo Type : ${docs[index]['ngoType']}'),
                      height3(),
                      Text('Country : ${docs[index]['ngoCountry']}'),
                      height3(),
                      Text('State : ${docs[index]['ngoState']}'),
                      height3(),
                      Text('city : ${docs[index]['ngoCity']}'),
                      height3(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.green,
                              ),
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('ngo')
                                  .doc('${docs[index]['email']}')
                                  .update(
                                {
                                  'isVerified': true,
                                },
                              );
                            },
                            icon: const Icon(Icons.done),
                            label: const Text('Accept'),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          ElevatedButton.icon(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.red,
                              ),
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('ngo')
                                  .doc('${docs[index]['email']}')
                                  .delete();
                            },
                            icon: const Icon(Icons.cancel_outlined),
                            label: const Text('Decline'),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }

  height3() {
    return const SizedBox(
      height: 3,
    );
  }
}
