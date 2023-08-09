class FoodModel {
  String? description;
  String? date;
  String? time;
  String? totalPersonCanFeed;
  String? weight;
  String? type;
  String? foodSource;
  String? imageUrl;
  bool? isDelivered;
  Map<String, dynamic>? userModel;
  Map<String, dynamic>? ngoModel;

  FoodModel({
    this.description,
    this.date,
    this.time,
    this.totalPersonCanFeed,
    this.weight,
    this.type,
    this.foodSource,
    this.userModel,
    this.ngoModel,
    this.imageUrl,
    this.isDelivered,
  });

  FoodModel.fromMap(Map<String, dynamic> map) {
    description = map['description'];
    date = map['date'];
    time = map['time'];
    totalPersonCanFeed = map['totalPersonCanFeed'];
    weight = map['weight'];
    type = map['type'];
    foodSource = map['foodSource'];
    userModel = map['userModel'];
    ngoModel = map['ngoModel'];
    imageUrl = map['imageUrl'];
    isDelivered = map['isDelivered'];
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'date': date,
      'time': time,
      'totalPersonCanFeed': totalPersonCanFeed,
      'weight': weight,
      'type': type,
      'foodSource': foodSource,
      'userModel': userModel,
      'ngoModel': ngoModel,
      'imageUrl': imageUrl,
      'isDelivered': isDelivered,
    };
  }
}
