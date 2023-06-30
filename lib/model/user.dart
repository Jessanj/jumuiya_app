import 'dart:convert';
//
// List<UserModel> userModelFromJson(String str) =>
//     List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));
//
// String userModelToJson(List<UserModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {

  UserModel({
    required this.id,
    required this.first_name,
    required this.middle_name,
    required this.last_name,
    required this.email,
    required this.address,
    required this.phone,
    required this.phone2,
    required this.website,
  });

  int id;
  String first_name;
  String middle_name;
  String last_name;
  String email;
  Address address;
  String phone;
  String website;
  String phone2;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    first_name: json["first_name"],
    middle_name: json["middle_name"],
    last_name: json["last_name"],
    email: json["email"],
    address: Address.fromJson(json["address"]),
    phone: json["phone"],
    phone2: json["phone"],
    website: json["website"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name" : first_name,
    "middle_name" : middle_name,
    "last_name" : last_name,
    "email": email,
    "address": address.toJson(),
    "phone1": phone,
    "phone2": phone2,
    "website": website,
  };
}

class Address {

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });

  String street;
  String suite;
  String city;
  String zipcode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json["street"],
    suite: json["suite"],
    city: json["city"],
    zipcode: json["zipcode"],
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "suite": suite,
    "city": city,
    "zipcode": zipcode,
  };
}

