class NgoModelPassword {
  String? name;
  String? email;
  String? mobileNumber;
  String? ngoType;
  String? ngoAddress;
  String? ngoCountry;
  String? ngoState;
  String? ngoCity;
  String? password;

  NgoModelPassword({
    this.email,
    this.mobileNumber,
    this.name,
    this.ngoAddress,
    this.ngoCity,
    this.ngoCountry,
    this.ngoState,
    this.ngoType,
    this.password,
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
      'password': password,
    };
  }
}
