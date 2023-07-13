import 'package:firebase_database/firebase_database.dart';
import 'package:food_for_all/screens/verify_screens/ngo_message.dart';
import 'package:get/get.dart';
import '../../models/ngo_model_pass.dart';
import '../../widgets/snack_bar.dart';

class StoreNgoData {
  NgoModelPassword ngoDataPasswordobj;
  StoreNgoData({required this.ngoDataPasswordobj});
  final allNgoRef = FirebaseDatabase.instance.ref('all-ngo');
  final verifiedNgoRef = FirebaseDatabase.instance.ref('verified-ngo');

  validate() {
    final ngoDataPassword = ngoDataPasswordobj.toMap();
    if (ngoDataPassword['name'].isEmpty ||
        ngoDataPassword['email'].isEmpty ||
        ngoDataPassword['password'].isEmpty ||
        ngoDataPassword['mobileNumber'].isEmpty ||
        ngoDataPassword['ngoType'].isEmpty ||
        ngoDataPassword['ngoAddress'].isEmpty ||
        ngoDataPassword['ngoCountry'] == 'null' ||
        ngoDataPassword['ngoState'] == 'null' ||
        ngoDataPassword['ngoCity'] == 'null') {
      snackBar("SIGN UP ERROR", 'some of the fields are empty');
      return;
    }

    if (!RegExp(r"^[a-z A-Z]+$").hasMatch(ngoDataPassword['name'])) {
      snackBar("SIGN UP ERROR", "please enter a valid name");
      return;
    }
    if (ngoDataPassword['password'].toString().length < 6) {
      snackBar("SIGN UP ERROR", "PASSWORD LENGTH MUST BE ATLEAST 6");
      return;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(ngoDataPassword['email'])) {
      snackBar("SIGN UP ERROR", "Please enter a valid email");
      return;
    }
    if (!RegExp(r"^(\+?\d[\d -]{8,12}\d)")
        .hasMatch(ngoDataPassword['mobileNumber'])) {
      snackBar("SIGN UP ERROR", "Please enter a valid mobile number");
      return;
    }
    storeAllNgoData(ngoDataPassword);
    Get.off(NgoMessage(name: ngoDataPassword['name']));
  }

  storeAllNgoData(Map<String, dynamic> ngoData) async {
    await FirebaseDatabase.instance
        .ref('all-ngo/${ngoData['name']}')
        .set(ngoData);
  }
}
