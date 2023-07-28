class UserModel {
  String? firstName;
  String? middleName;
  String? lastName;
  String? userName;
  String? gender;
  String? address;
  String? email;
  String? mobileNumber;
  int? numberOfDonations;
  int? numberOfSuccessfullDonations;
  bool? emailVerified;
  UserModel({
    this.email,
    this.mobileNumber,
    this.userName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.address,
    this.gender,
    this.numberOfDonations,
    this.numberOfSuccessfullDonations,
    this.emailVerified,
  });
  UserModel.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    mobileNumber = map['mobileNumber'];
    userName = map['userName'];
    firstName = map['firstName'];
    middleName = map['middleName'];
    lastName = map['lastName'];
    address = map['address'];
    gender = map['gender'];
    numberOfDonations = map['numberOfDonations'];
    numberOfSuccessfullDonations = map['numberOfSuccessfullDonations'];
    emailVerified = map['emailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'mobileNumber': mobileNumber,
      'userName': userName,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'address': address,
      'gender': gender,
      'numberOfDonations': numberOfDonations,
      'numberOfSuccessfullDonations': numberOfSuccessfullDonations,
      'emailVerified' : emailVerified,
    };
  }
}
