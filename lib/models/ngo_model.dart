class NgoModel {
  String? name;
  String? email;
  String? mobileNumber;
  String? ngoType;
  String? ngoAddress;
  String? ngoCountry;
  String? ngoState;
  String? ngoCity;

  NgoModel({
    this.email,
    this.mobileNumber,
    this.name,
    this.ngoAddress,
    this.ngoCity,
    this.ngoCountry,
    this.ngoState,
    this.ngoType,
  });

  NgoModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    email = map['email'];
    mobileNumber = map['mobileNumber'];
    ngoType = map['ngoType'];
    ngoAddress = map['ngoAddress'];
    ngoCountry = map['ngoCountry'];
    ngoState = map['ngoState'];
    ngoCity = map['ngoCity'];
  }

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
    };
  }
}
