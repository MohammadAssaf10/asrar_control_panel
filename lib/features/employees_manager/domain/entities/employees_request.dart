import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EmployeeRequest extends Equatable {
  final String employeeID;
  final Timestamp timeStamp;
  final String oldName;
  final String newName;
  final String oldPhoneNumber;
  final String newPhoneNumber;
  final String oldImageName;
  final String newImageName;
  final String oldImageURL;
  final String newImageURL;

  const EmployeeRequest({
    required this.employeeID,
    required this.timeStamp,
    required this.oldName,
    required this.newName,
    required this.oldPhoneNumber,
    required this.newPhoneNumber,
    required this.oldImageName,
    required this.newImageName,
    required this.oldImageURL,
    required this.newImageURL,
  });

  EmployeeRequest copyWith({
    String? employeeID,
    Timestamp? timeStamp,
    String? oldName,
    String? newName,
    String? oldPhoneNumber,
    String? newPhoneNumber,
    String? oldImageName,
    String? newImageName,
    String? oldImageURL,
    String? newImageURL,
  }) {
    return EmployeeRequest(
      employeeID: employeeID ?? this.employeeID,
      timeStamp: timeStamp ?? this.timeStamp,
      oldName: oldName ?? this.oldName,
      newName: newName ?? this.newName,
      oldPhoneNumber: oldPhoneNumber ?? this.oldPhoneNumber,
      newPhoneNumber: newPhoneNumber ?? this.newPhoneNumber,
      oldImageName: oldImageName ?? this.oldImageName,
      newImageName: newImageName ?? this.newImageName,
      oldImageURL: oldImageURL ?? this.oldImageURL,
      newImageURL: newImageURL ?? this.newImageURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employeeID': employeeID,
      'timeStamp': timeStamp,
      'oldName': oldName,
      'newName': newName,
      'oldPhoneNumber': oldPhoneNumber,
      'newPhoneNumber': newPhoneNumber,
      'oldImageName': oldImageName,
      'newImageName': newImageName,
      'oldImageURL': oldImageURL,
      'newImageURL': newImageURL,
    };
  }

  factory EmployeeRequest.fromMap(Map<String, dynamic> map) {
    return EmployeeRequest(
      employeeID: map['employeeID'],
      timeStamp: map['timeStamp'],
      oldName: map['oldName'],
      newName: map['newName'],
      oldPhoneNumber: map['oldPhoneNumber'],
      newPhoneNumber: map['newPhoneNumber'],
      oldImageName: map['oldImageName'],
      newImageName: map['newImageName'],
      oldImageURL: map['oldImageURL'],
      newImageURL: map['newImageURL'],
    );
  }

  @override
  List<Object?> get props => [
        employeeID,
        timeStamp,
        oldName,
        newName,
        oldPhoneNumber,
        newPhoneNumber,
        oldImageName,
        newImageName,
        oldImageURL,
        newImageURL,
      ];
}
