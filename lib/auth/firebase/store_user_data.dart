import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class StoreUserData {
  final _auth = FirebaseAuth.instance;
  final allUserRef = FirebaseDatabase.instance.ref('all-users');
  final verifiedUserRef = FirebaseDatabase.instance.ref('verified-user');
  allUSers(String email, String username) async {
    final uid = _auth.currentUser?.uid;
    await allUserRef.child(uid.toString()).set({
      'uid': uid,
      'email': email,
      'username': username,
    });
  }
  verifiedUSer(String email, String username) async {
    final uid = _auth.currentUser?.uid;
    await verifiedUserRef.child(uid.toString()).set({
      'uid': uid,
      'email': email,
      'username': username,
    });
  }
}
