// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'permissions.dart';

class Employee {

  String employeeID;
  String name;
  String email;
  String phoneNumber;
  String idNumber;
  String national;
  Permissions permissions;
  String imageName;
  String imageURL;
  List<String> employeeTokenList;

  Employee({
    required this.employeeID,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.idNumber,
    required this.national,
    required this.permissions,
    required this.imageName,
    required this.imageURL,
    required this.employeeTokenList,
  });

  Employee copyWith({
    String? employeeID,
    String? name,
    String? email,
    String? phoneNumber,
    String? idNumber,
    String? national,
    Permissions? permissions,
    String? imageName,
    String? imageURL,
    List<String>? employeeTokenList,
  }) {
    return Employee(
      employeeID: employeeID ?? this.employeeID,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      idNumber: idNumber ?? this.idNumber,
      national: national ?? this.national,
      permissions: permissions ?? this.permissions,
      imageName: imageName ?? this.imageName,
      imageURL: imageURL ?? this.imageURL,
      employeeTokenList: employeeTokenList ?? this.employeeTokenList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeID': employeeID,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'idNumber': idNumber,
      'national': national,
      'permissions': permissions.toMap(),
      'imageName': imageName,
      'imageURL': imageURL,
      'employeeTokenList': employeeTokenList,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      employeeID: (map['employeeID'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      phoneNumber: (map['phoneNumber'] ?? '') as String,
      idNumber: (map['idNumber'] ?? '') as String,
      national: (map['national'] ?? '') as String,
      permissions: Permissions.fromMap(map['permissions'] as Map<String,dynamic>),
      imageName: (map['imageName'] ?? '') as String,
      imageURL: (map['imageURL'] ?? '') as String,
      employeeTokenList: List<String>.from((map['employeeTokenList'] ?? const <String>[]) as List<String>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) => Employee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Employee(employeeID: $employeeID, name: $name, email: $email, phoneNumber: $phoneNumber, idNumber: $idNumber, national: $national, permissions: $permissions, imageName: $imageName, imageURL: $imageURL, employeeTokenList: $employeeTokenList)';
  }

  @override
  bool operator ==(covariant Employee other) {
    if (identical(this, other)) return true;
  
    return 
      other.employeeID == employeeID &&
      other.name == name &&
      other.email == email &&
      other.phoneNumber == phoneNumber &&
      other.idNumber == idNumber &&
      other.national == national &&
      other.permissions == permissions &&
      other.imageName == imageName &&
      other.imageURL == imageURL &&
      listEquals(other.employeeTokenList, employeeTokenList);
  }

  @override
  int get hashCode {
    return employeeID.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      idNumber.hashCode ^
      national.hashCode ^
      permissions.hashCode ^
      imageName.hashCode ^
      imageURL.hashCode ^
      employeeTokenList.hashCode;
  }
}
