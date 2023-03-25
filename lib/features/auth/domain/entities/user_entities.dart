import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String imageURL;
  final String imageName;
  final List<String> userTokenList;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.imageURL,
    required this.imageName,
    required this.userTokenList,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? imageURL,
    String? imageName,
    List<String>? userTokenList,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageURL: imageURL ?? this.imageURL,
      imageName: imageName ?? this.imageName,
      userTokenList: userTokenList ?? this.userTokenList,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'emailG': email});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'imageURL': imageURL});
    result.addAll({'imageName': imageName});
    result.addAll({'userTokenList': userTokenList});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['emailG'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      imageURL: map['imageURL'] ?? '',
      imageName: map['imageName'] ?? '',
      userTokenList: List<String>.from(map['userTokenList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, imageURL: $imageURL, imageName: $imageName, userTokenList: $userTokenList)';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        imageName,
        imageURL,
        userTokenList,
      ];
}
