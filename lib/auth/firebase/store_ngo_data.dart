import 'package:firebase_database/firebase_database.dart';
import 'package:food_for_all/models/ngo_model.dart';
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
    ngoDataPassword.remove('password');
    NgoModel ngoData = NgoModel.fromMap(ngoDataPassword);
    storeAllNgoData(ngoData);
    Get.off(NgoMessage(name: ngoData.toMap()['name']));
  }

  storeAllNgoData(ngoData) async {
    await allNgoRef.child(ngoData.name.toString()).set(ngoData.toMap());
  }

  storeVerifiedNgoData(ngoData) async {
    await verifiedNgoRef.child(ngoData.name.toString()).set(ngoData.toMap());
  }
}
