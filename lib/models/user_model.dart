class UserModel {
  String? uid;
  String? name;
  String? email;

  UserModel({
    this.uid,
    this.name,
    this.email,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    name = map['name'];
    email = map['email'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}
