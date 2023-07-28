import 'dart:io';
import 'package:food_for_all/models/ngo_model_new.dart';
import 'package:food_for_all/models/user_model.dart';

class FoodModel {
  String? description;
  String? date;
  String? time;
  String? totalPersonCanFeede;
  String? weight;
  String? type;
  String? foodSource;
  File? image;
  UserModel? userModel;
  NgoModel? ngoModel;

  FoodModel({
    this.description,
    this.date,
    this.time,
    this.totalPersonCanFeede,
    this.weight,
    this.type,
    this.foodSource,
    this.image,
    this.userModel,
    this.ngoModel,
  });

  FoodModel.fromMap(Map<String, dynamic> map) {
    description = map['description'];
    date = map['date'];
    time = map['time'];
    totalPersonCanFeede = map['totalPersonCanFeede'];
    weight = map['weight'];
    type = map['type'];
    foodSource = map['foodSource'];
    image = map['image'];
    userModel = map['userModel'];
    ngoModel = map['ngoModel'];
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'date': date,
      'time': time,
      'totalPersonCanFeede': totalPersonCanFeede,
      'weight': weight,
      'type': type,
      'foodSource': foodSource,
      'image': image,
      'userModel': userModel,
      'ngoModel': ngoModel,
    };
  }
}
