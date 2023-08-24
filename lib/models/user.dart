
class UserModel {

  UserModel({
    required this.id,
    required this.first_name,
    required this.middle_name,
    required this.last_name,
    required this.email,
    required this.address,
    required this.phone,
  });

  int id;
  String first_name;
  String middle_name;
  String last_name;
  String email;
  String address;
  String phone;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    first_name: json["first_name"].toString(),
    middle_name: json["middle_name"].toString(),
    last_name: json["last_name"].toString(),
    email: json["email"].toString(),
    address:  json["address"].toString(),
    phone: json["phone"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name" : first_name,
    "middle_name" : middle_name,
    "last_name" : last_name,
    "email": email,
    "address": address,
    "phone1": phone,
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

