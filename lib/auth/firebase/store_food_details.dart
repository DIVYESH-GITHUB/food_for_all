// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_for_all/models/food_model.dart';
import 'package:food_for_all/widgets/snack_bar.dart';

class StoreFoodDetails {
  FoodModel foodModel;
  StoreFoodDetails({
    required this.foodModel,
  });
  validate() {
    if (foodModel.description!.isEmpty) {
      snackBar('Error', 'Please provide description');
      return;
    }
    if (foodModel.date!.isEmpty) {
      snackBar('Error', 'Please provide date');
      return;
    }
    if (foodModel.time!.isEmpty) {
      snackBar('Error', 'Please provide time');
      return;
    }
    if (foodModel.totalPersonCanFeed!.isEmpty) {
      snackBar('Error', 'Please provide totalPersonCanFeed');
      return;
    }
    if (foodModel.weight!.isEmpty) {
      snackBar('Error', 'Please provide weight');
      return;
    }
    if (foodModel.type!.isEmpty) {
      snackBar('Error', 'Please provide type');
      return;
    }
    if (foodModel.foodSource!.isEmpty) {
      snackBar('Error', 'Please provide foodSource');
      return;
    }
    storeData();
  }

  storeData() async {

    await FirebaseFirestore.instance
        .collection('users')
        .doc('divyeshpindaria09@gmail.com')
        .get()
        .then((value) {
      foodModel.userModel = value.data();
    });

    await FirebaseFirestore.instance
        .collection('foods')
        .doc('${FirebaseAuth.instance.currentUser?.email}+${DateTime.now()}')
        .set(foodModel.toMap());
    
  }
}
