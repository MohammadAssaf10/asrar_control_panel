import 'package:equatable/equatable.dart';

class CompanyEntities extends Equatable {
  final String fullName; // Name with subsequent(.jpg or .png)
  final String name;
  final String image;

  const CompanyEntities({
    required this.fullName,
    required this.image,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'name': name,
      'image': image,
    };
  }

  factory CompanyEntities.fromMap(Map<String, dynamic> map) {
    return CompanyEntities(
      fullName: map['fullName'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  @override
  List<Object?> get props => [fullName, image];
}
