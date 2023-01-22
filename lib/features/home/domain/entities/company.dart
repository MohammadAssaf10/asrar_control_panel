import 'package:equatable/equatable.dart';

class CompanyEntities extends Equatable {
  final String name;
  final String image;

  const CompanyEntities({required this.name, required this.image});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }

  factory CompanyEntities.fromMap(Map<String, dynamic> map) {
    return CompanyEntities(
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  @override
  List<Object?> get props => [name, image];
}
