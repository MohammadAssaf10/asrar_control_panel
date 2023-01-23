import 'dart:convert';

import 'permissions.dart';

class Employee {
  String name;
  String email;
  String phonNumber;
  String idNumber;
  String national;
  Permissions permissions;

  Employee({
    required this.name,
    required this.email,
    required this.phonNumber,
    required this.idNumber,
    required this.national,
    required this.permissions,
  });

  Employee copyWith({
    String? name,
    String? email,
    String? phonNumber,
    String? idNumber,
    String? national,
    Permissions? permissions,
  }) {
    return Employee(
      name: name ?? this.name,
      email: email ?? this.email,
      phonNumber: phonNumber ?? this.phonNumber,
      idNumber: idNumber ?? this.idNumber,
      national: national ?? this.national,
      permissions: permissions ?? this.permissions,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phonNumber': phonNumber});
    result.addAll({'idNumber': idNumber});
    result.addAll({'national': national});
    result.addAll({'permissions': permissions.toMap()});

    return result;
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phonNumber: map['phonNumber'] ?? '',
      idNumber: map['idNumber'] ?? '',
      national: map['national'] ?? '',
      permissions: Permissions.fromMap(map['permissions'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee(name: $name, email: $email, phonNumber: $phonNumber, idNumber: $idNumber, national: $national, permissions: $permissions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Employee &&
        other.name == name &&
        other.email == email &&
        other.phonNumber == phonNumber &&
        other.idNumber == idNumber &&
        other.national == national &&
        other.permissions == permissions;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phonNumber.hashCode ^
        idNumber.hashCode ^
        national.hashCode ^
        permissions.hashCode;
  }
}
