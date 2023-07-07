import 'package:firebase_database/firebase_database.dart';
import 'package:food_for_all/models/ngo_model.dart';

class StoreNgoData {
  final allNgoRef = FirebaseDatabase.instance.ref('all-ngo');
  final verifiedNgoRef = FirebaseDatabase.instance.ref('verified-ngo');
  storeAllNgoData(
    String name,
    String email,
    String mobileNumber,
    String ngoType,
    String ngoAddress,
    String ngoCountry,
    String ngoState,
    String ngoCity,
  ) async {
    final NgoModel ngoData = NgoModel(
      email: email,
      mobileNumber: mobileNumber,
      name: name,
      ngoAddress: ngoAddress,
      ngoCity: ngoCity,
      ngoCountry: ngoCountry,
      ngoState: ngoState,
      ngoType: ngoType,
    );
    await allNgoRef.child(name).set(ngoData.toMap());
  }
}
