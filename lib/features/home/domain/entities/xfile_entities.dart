import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class XFileEntities extends Equatable {
  final String name;
  final Uint8List xFileAsBytes;
  const XFileEntities({required this.name,required this.xFileAsBytes});

  @override
  List<Object?> get props => [name, xFileAsBytes];
}
