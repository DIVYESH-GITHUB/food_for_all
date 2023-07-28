class NgoModel {
  String? name;
  String? email;
  String? mobileNumber;
  String? ngoType;
  String? ngoAddress;
  String? ngoCountry;
  String? ngoState;
  String? ngoCity;
  bool? isVerified;
  bool? emailVerified;
  int? numberOfDontationReceived;

  NgoModel({
    this.name,
    this.email,
    this.mobileNumber,
    this.ngoType,
    this.ngoAddress,
    this.ngoCountry,
    this.ngoState,
    this.ngoCity,
    this.isVerified,
    this.emailVerified,
    this.numberOfDontationReceived,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'ngoType': ngoType,
      'ngoAddress': ngoAddress,
      'ngoCountry': ngoCountry,
      'ngoState': ngoState,
      'ngoCity': ngoCity,
      'isVerified': isVerified,
      'emailVerified': emailVerified,
      'numberOfDontationReceived': numberOfDontationReceived,
    };
  }
}
