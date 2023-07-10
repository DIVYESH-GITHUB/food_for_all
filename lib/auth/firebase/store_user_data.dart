import 'package:firebase_database/firebase_database.dart';

class StoreUserData {
  final Map<String, dynamic> userData;
  StoreUserData({required this.userData});
  final allUserRef = FirebaseDatabase.instance.ref('all-users');
  final verifiedUserRef = FirebaseDatabase.instance.ref('verified-user');
  allUSers() async {
    final uid = userData['uid'];
    await allUserRef.child(uid.toString()).set(userData);
  }

  verifiedUSer() async {
    final uid = userData['uid'];
    await verifiedUserRef.child(uid.toString()).set(userData);
  }
}
