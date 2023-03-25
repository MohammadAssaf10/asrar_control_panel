import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'permissions.dart';

class Employee {
  String employeeID;
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
    final result = <String, dynamic>{};
  
    result.addAll({'employeeID': employeeID});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'idNumber': idNumber});
    result.addAll({'national': national});
    result.addAll({'imageName': imageName});
    result.addAll({'imageURL': imageURL});
    result.addAll({'permissions': permissions.toMap()});
  
    return result;
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      employeeID: map['employeeID'] ?? '',
      employeeID: map['employeeID'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      idNumber: map['idNumber'] ?? '',
      national: map['national'] ?? '',
      permissions: Permissions.fromMap(map['permissions']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) => Employee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee(employeeID: $employeeID, name: $name, email: $email, phonNumber: $phonNumber, idNumber: $idNumber, national: $national, permissions: $permissions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Employee &&
      other.employeeID == employeeID &&
      other.name == name &&
      other.email == email &&
      other.phonNumber == phonNumber &&
      other.idNumber == idNumber &&
      other.national == national &&
      other.permissions == permissions;
  }

  @override
  int get hashCode {
    return employeeID.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phonNumber.hashCode ^
      idNumber.hashCode ^
      national.hashCode ^
      permissions.hashCode;
  }
}
