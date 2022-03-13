import './adress_model.dart';

class UserModel {
  String id;
  String? name;
  String email;
  String? phoneNumber;
  List<AddressModel>? adresses;

  UserModel(
      {required this.id,
      this.name,
      required this.email,
      this.phoneNumber,
      this.adresses});

  factory UserModel.fromJson(Map<dynamic, dynamic> jsonData) {
    return UserModel(
      id: jsonData['id'],
      email: jsonData['email'],
      name: jsonData['name'],
      phoneNumber: jsonData['phone'],
    );
  }
  toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phoneNumber,
    };
  }
}
