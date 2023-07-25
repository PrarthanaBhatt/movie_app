// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String name;
  String email;
  String dob;
  String gender;
  String state;
  int mobileNo;
  String password;

  UserModel({
    required this.name,
    required this.email,
    required this.dob,
    required this.gender,
    required this.state,
    required this.mobileNo,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'dob': dob,
      'gender': gender,
      'state': state,
      'mobileNo': mobileNo,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      dob: map['dob'],
      gender: map['gender'],
      state: map['state'],
      mobileNo: map['mobileNo'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
